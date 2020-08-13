//
//  PlanningHostSessionLandingViewModel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

class PlanningHostSessionLandingViewModel: ObservableObject {
    private var service: PlanningHostSessionLandingServiceProtocol
    private var cancellable: AnyCancellable?
    private var availableCards: [PlanningCard]
    private(set) var sessionCode: String = ""
    @Published var state: PlanningSessionLandingState = .loading
    @Published var sessionName: String
    @Published var participants = [PlanningParticipant]()
    @Published var showInitialShareModal: Bool = false
    @Published var ticket: PlanningTicket?
    
    var participantList: [PlanningParticipantRowViewModel] {
        participants.map {
            PlanningParticipantRowViewModel(participantName: $0.name,
                                            votingValue: participantVotedValue($0) ?? "")
        }
    }
    
    init(sessionName: String, availableCards: [PlanningCard]) {
        self.service = PlanningHostSessionLandingService()
        self.sessionName = sessionName
        self.availableCards = availableCards
        startSession()
    }
    
    func sendStartSessionCommand() {
        let commandMessage = PlanningStartSessionMessage(sessionName: sessionName, availableCards: availableCards)
        sendCommand(.startSession(commandMessage))
    }
    
    func sendAddTicketCommand(identifier: String, description: String) {
        let commandMessage = PlanningAddTicketMessage(identifier: identifier, description: description)
        sendCommand(.addTicket(commandMessage))
    }
    
    private func participantVotedValue(_ participant: PlanningParticipant) -> String? {
        switch state {
        case .voting, .finishedVoting:
            let selectedCard = ticket?.ticketVotes.first(where: { $0.user.id == participant.id })?.selectedCard
            return selectedCard?.title ?? "..."
        default:
            return nil
        }
    }
    
    private func sendCommand(_ command: PlanningCommands.HostSend) {
        Log.log(level: .debug, category: .planning, message: "Host sending command: %@", args: String(describing: command))
        do {
            try service.sendCommand(command)
        } catch let error as EncodingError {
            executeError(code: error.errorCode, description: error.errorCustomDescription)
        } catch {
            executeError(code: "3105", description: error.localizedDescription)
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
    
    private func executeError(code: String, description: String) {
        Log.log(level: .error, category: .planning, message: "Host executing error state: %@-%@", args: code, description)
        let planningError = PlanningLandingError(code: code, description: description)
        self.state = .error(planningError)
    }
    
    private func executeCommand(_ command: PlanningCommands.HostReceive) {
        Log.log(level: .debug, category: .planning, message: "Host executing received command: %{private}@", args: String(describing: command))
        switch command {
        case .noneState(let message):
            self.state = .none
            parseStateMessage(message)
            
            if !showInitialShareModal {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.showInitialShareModal = true
                }
            }
        case .votingState(let message):
            self.state = .voting
            parseStateMessage(message)
        case .finishedState(let message):
            self.state = .finishedVoting
            parseStateMessage(message)
        case .invalidCommand(let message):
            executeError(code: message.code, description: message.description)
        }
    }
    
    private func parseStateMessage(_ message: PlanningSessionStateMessage) {
        self.participants = message.participants
        self.sessionCode = message.sessionCode
        self.sessionName = message.sessionName
        self.ticket = message.ticket
        
        for participant in self.participants {
            participant.selectedCard = ticket?.ticketVotes.first(where: { $0.user.id == participant.id })?.selectedCard
        }
    }
}
