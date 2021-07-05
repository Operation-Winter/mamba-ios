//
//  PlanningSessionLandingViewModel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine
import UIKit
import SwiftUI
import MambaNetworking

class PlanningSessionLandingViewModel<Send: Encodable, Receive: Decodable>: ObservableObject {
    private var service: PlanningSessionLandingService<Send, Receive>
    private var cancellable: AnyCancellable?
    private(set) var sessionCode: String = ""
    private(set) var participantName: String = ""
    private(set) var availableCards: [PlanningCard] = []
    private(set) var uuid = UUID()
    @Published var state: PlanningSessionLandingState = .loading
    @Published var sessionName: String = ""
    @Published var participants = [PlanningParticipant]()
    @Published var ticket: PlanningTicket?
    @Published var selectedCard: PlanningCard?
    @Published var dismiss: Bool = false
    
    var participantList: [PlanningParticipantRowViewModel] {
        switch state {
        case .voting: return votingParticipantRows()
        case .finishedVoting: return outlierParticipantRows()
        default: return participantRows()
        }
    }
    
    var barGraphEntries: [CombinedBarGraphEntry] {
        guard let ticketVotes = ticket?.ticketVotes else { return [] }
        let groupedVotes = Dictionary(grouping: ticketVotes) { $0.selectedCard }
        
        return groupedVotes.compactMap {
            guard let selectedCard = $0.key else { return nil }
            return CombinedBarGraphEntry(title: selectedCard.title, count: $0.value.count)
        }.sorted {
            $0.count > $1.count
        }
    }
    
    var toolBarHidden: Bool {
        switch state {
        case .error(_), .loading: return true
        default: return false
        }
    }
    
    var gridItems: [GridItem] = [
        GridItem(.adaptive(minimum: 200, maximum: 400))
    ]

    var shareSessionCode: String {
        sessionCode
    }
    
    var shareSessionLink: URL {
        URLCenter.shared.planningJoinURL(sessionCode: sessionCode)
    }
    
    init(websocketURL: URL) {
        self.service = PlanningSessionLandingService<Send, Receive>(sessionURL: websocketURL)
        startSession()
    }
    
    init(service: PlanningSessionLandingService<Send, Receive>) {
        self.service = service
        startSession()
    }
    
    public func configure(availableCards: [PlanningCard]) {
        self.availableCards = availableCards
    }
    
    public func configure(sessionCode: String) {
        self.sessionCode = sessionCode
    }
    
    public func configure(participantName: String) {
        self.participantName = participantName
    }
    
    public func sendCommand(_ command: Send) {
        Log.planning.logger.debug("Sending command: \(String(describing: command))")
        do {
            try service.send(command: command)
        } catch let error as EncodingError {
            executeError(code: error.errorCode, description: error.errorCustomDescription)
        } catch {
            executeError(code: "3105", description: error.localizedDescription)
        }
    }
    
    public func executeCommand(_ command: Receive) {
        Log.planning.logger.debug("Executing received command: \(String(describing: command))")
    }
    
    public func parseStateMessage(_ message: PlanningSessionStateMessage) {
        self.participants = message.participants
        self.sessionCode = message.sessionCode
        self.sessionName = message.sessionName
        self.ticket = message.ticket
        self.availableCards = message.availableCards
    }
    
    public func executeError(code: String, description: String) {
        Log.planning.logger.error("Executing error state: \(code) \(description)")
        let planningError = PlanningLandingError(code: code, description: description)
        self.state = .error(planningError)
    }
    
    public func closeSession() {
        Log.planning.logger.info("Closing session")
        service.close()
    }
    
    public func shareSessionQRCode() -> UIImage? {
        let data = shareSessionLink.absoluteString.data(using: String.Encoding.ascii)
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)

        guard let output = filter.outputImage?.transformed(by: transform) else { return nil }
        return UIImage(ciImage: output)
    }
    
    private func participantRows() -> [PlanningParticipantRowViewModel] {
        participants.map {
            PlanningParticipantRowViewModel(participantId: $0.participantId,
                                            participantName: $0.name)
        }
    }
    
    private func votingFinishedParticipantRowImage(cardSelected: Bool) -> String? {
        cardSelected ? nil : "arrowshape.turn.up.right"
    }
    
    private func votingParticipantRowImage(skipped: Bool, cardSelected: Bool) -> String {
        if skipped {
            return "arrowshape.turn.up.right"
        } else {
            return cardSelected ? "checkmark.circle" : "rectangle.and.pencil.and.ellipsis"
        }
    }
    
    private func votingParticipantRows() -> [PlanningParticipantRowViewModel] {
        participants.compactMap { participant in
            let ticketVote = ticket?.ticketVotes.first(where: { $0.participantId == participant.participantId })
            let imageName = votingParticipantRowImage(skipped: ticketVote?.skipped ?? false, cardSelected: ticketVote?.selectedCard != nil)
            return PlanningParticipantRowViewModel(participantId: participant.participantId,
                                                   participantName: participant.name,
                                                   votingImageName: imageName)
        }
    }
    
    private func outlierParticipantRows() -> [PlanningParticipantRowViewModel] {
        guard let ticketVotes = ticket?.ticketVotes else { return participantRows() }
        let filteredVotes = ticketVotes.filter { $0.selectedCard != nil }
        let filteredGroupedVotes = Dictionary(grouping: filteredVotes) { $0.selectedCard }.sorted { $0.value.count < $1.value.count }
        let meanCount = filteredGroupedVotes.last?.value.count ?? 0

        let groupedVotes = Dictionary(grouping: ticketVotes) { $0.selectedCard }.sorted {
            if $0.value.first?.selectedCard == nil {
                return false
            } else if $1.value.first?.selectedCard == nil {
                return true
            } else {
                return $0.value.count < $1.value.count
            }
        }
        
        var list = [PlanningParticipantRowViewModel]()
        for group in groupedVotes {
            let filteredParticipants: [PlanningParticipantRowViewModel] = group.value.compactMap { ticketVote in
                guard let participantName = participants.first(where: { $0.participantId == ticketVote.participantId })?.name else {
                    return nil
                }
                let meanCard = group.value.count == meanCount ? ticketVote.selectedCard : nil
                let highlighted = meanCard != ticketVote.selectedCard && !ticketVote.skipped
                let imageName = votingFinishedParticipantRowImage(cardSelected: !ticketVote.skipped)
                return PlanningParticipantRowViewModel(participantId: ticketVote.participantId,
                                                       participantName: participantName,
                                                       votingValue: ticketVote.selectedCard?.title,
                                                       votingImageName: imageName,
                                                       highlighted: highlighted)
            }
            list.append(contentsOf: filteredParticipants)
        }
        return list
    }
    
    private func startSession() {
        guard cancellable == nil else { return }
        cancellable = service.startSession()
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] networkError in
                switch networkError {
                case .finished:
                    self?.dismiss = true
                case .failure(let error):
                    self?.executeError(code: error.errorCode, description: error.errorDescription)
                }
            }, receiveValue: { [weak self] result in
                switch result {
                case .success(let command):
                    self?.executeCommand(command)
                case .failure(let error):
                    self?.executeError(code: error.errorCode, description: error.errorDescription)
                }
            })
    }
}
