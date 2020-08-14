//
//  PlanningSessionLandingViewModel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

class PlanningSessionLandingViewModel<Send: Encodable, Receive: Decodable>: ObservableObject {
    private var service: PlanningSessionLandingService<Send, Receive>
    private var cancellable: AnyCancellable?
    private(set) var sessionCode: String = ""
    private(set) var participantName: String = ""
    private(set) var availableCards: [PlanningCard] = []
    @Published var state: PlanningSessionLandingState = .loading
    @Published var sessionName: String = ""
    @Published var participants = [PlanningParticipant]()
    @Published var ticket: PlanningTicket?
    @Published var selectedCard: PlanningCard?
    
    var participantList: [PlanningParticipantRowViewModel] {
        switch state {
        case .finishedVoting: return outlierParticipantRows()
        default: return participantRows()
        }
    }
    
    var barGraphEntries: [CombinedBarGraphEntry] {
        guard let ticketVotes = ticket?.ticketVotes else { return [] }
        let groupedVotes = Dictionary(grouping: ticketVotes) { $0.selectedCard }
        
        return groupedVotes.map {
            return CombinedBarGraphEntry(title: $0.key.title, count: $0.self.value.count)
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
    
    init(websocketURL: URL) {
        self.service = PlanningSessionLandingService<Send, Receive>(sessionURL: websocketURL)
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
        Log.log(level: .debug, category: .planning, message: "Sending command: %@", args: String(describing: command))
        do {
            try service.send(command: command)
        } catch let error as EncodingError {
            executeError(code: error.errorCode, description: error.errorCustomDescription)
        } catch {
            executeError(code: "3105", description: error.localizedDescription)
        }
    }
    
    public func executeCommand(_ command: Receive) {
        Log.log(level: .debug, category: .planning, message: "Executing received command: %{private}@", args: String(describing: command))
    }
    
    public func parseStateMessage(_ message: PlanningSessionStateMessage) {
        self.participants = message.participants
        self.sessionCode = message.sessionCode
        self.sessionName = message.sessionName
        self.ticket = message.ticket
        self.availableCards = message.availableCards
        
        for participant in self.participants {
            participant.selectedCard = ticket?.ticketVotes.first(where: { $0.user.id == participant.id })?.selectedCard
        }
    }
    
    public func executeError(code: String, description: String) {
        Log.log(level: .error, category: .planning, message: "Executing error state: %@-%@", args: code, description)
        let planningError = PlanningLandingError(code: code, description: description)
        self.state = .error(planningError)
    }
    
    private func participantRows() -> [PlanningParticipantRowViewModel] {
        participants.map {
            PlanningParticipantRowViewModel(participantName: $0.name,
                                            votingValue: participantVotedValue($0) ?? "")
        }
    }
    
    private func outlierParticipantRows() -> [PlanningParticipantRowViewModel] {
        guard let ticketVotes = ticket?.ticketVotes else { return participantRows() }
        let groupedVotes = Dictionary(grouping: ticketVotes) { $0.selectedCard }.sorted { $0.value.count < $1.value.count }
        let meanCount = groupedVotes.last?.value.count ?? 0
        var list = [PlanningParticipantRowViewModel]()
        for group in groupedVotes {
            let filteredParticipants: [PlanningParticipantRowViewModel] = participants.filter {
                group.key == $0.selectedCard
            }.map {
                let meanCard = group.value.count == meanCount ? $0.selectedCard : groupedVotes.last?.key
                let highlighted = meanCard != $0.selectedCard
                return PlanningParticipantRowViewModel(participantName: $0.name,
                                                       votingValue: participantVotedValue($0) ?? "",
                                                       highlighted: highlighted)
            }
            list.append(contentsOf: filteredParticipants)
        }
        return list
    }
    
    private func participantVotedValue(_ participant: PlanningParticipant) -> String? {
        switch state {
        case .voting:
            let selectedCard = ticket?.ticketVotes.first(where: { $0.user.id == participant.id })?.selectedCard
            return selectedCard == nil ? "􀀀" : "􀁣"
        case .finishedVoting:
            let selectedCard = ticket?.ticketVotes.first(where: { $0.user.id == participant.id })?.selectedCard
            return selectedCard?.title ?? "Skipped"
        default:
            return nil
        }
    }
    
    private func startSession() {
        guard cancellable == nil else { return }
        cancellable = service.startSession()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { networkError in
                switch networkError {
                case .finished:
                    //TODO: MAM-61
                    break
                case .failure(let error):
                    self.executeError(code: error.errorCode, description: error.errorDescription)
                }
            }, receiveValue: { result in
                switch result {
                case .success(let command):
                    self.executeCommand(command)
                case .failure(let error):
                    self.executeError(code: error.errorCode, description: error.errorDescription)
                }
            })
    }
}
