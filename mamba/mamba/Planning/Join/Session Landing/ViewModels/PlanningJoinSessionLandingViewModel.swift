//
//  PlanningJoinSessionLandingView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

class PlanningJoinSessionLandingViewModel: ObservableObject {
    private var service: PlanningJoinSessionLandingServiceProtocol
    private var sessionCode: String
    private var participantName: String
    private var cancellable: AnyCancellable?
    private(set) var availableCards: [PlanningCard] = []
    @Published var state: PlanningSessionLandingState = .loading
    @Published var sessionName: String = ""
    @Published var participants = [PlanningParticipant]()
    @Published var ticket: PlanningTicket?
    @Published var selectedCard: PlanningCard? {
        didSet {
            sendVoteCommand()
        }
    }
    
    var participantList: [PlanningParticipantRowViewModel] {
        participants.map {
            PlanningParticipantRowViewModel(participantName: $0.name,
                                            votingValue: participantVotedValue($0) ?? "")
        }
    }
    
    init(sessionCode: String, participantName: String) {
        self.service = PlanningJoinSessionLandingService()
        self.sessionCode = sessionCode
        self.participantName = participantName
        startSession()
    }
    
    func sendJoinSessionCommand() {
        let commandMessage = PlanningJoinSessionMessage(sessionCode: sessionCode, participantName: participantName)
        sendCommand(.joinSession(commandMessage))
    }
    
    private func participantVotedValue(_ participant: PlanningParticipant) -> String? {
        switch state {
        case .finishedVoting:
            let selectedCard = ticket?.ticketVotes.first(where: { $0.user.id == participant.id })?.selectedCard
            return selectedCard?.title ?? "Skipped"
        default:
            return nil
        }
    }
    
    private func sendVoteCommand() {
        guard
            let ticketId = ticket?.identifier,
            let selectedCard = selectedCard
        else {
            return
        }
        let commandMessage = PlanningVoteMessage(ticketId: ticketId, selectedCard: selectedCard)
        sendCommand(.vote(commandMessage))
    }
    
    private func sendCommand(_ command: PlanningCommands.JoinSend) {
        Log.log(level: .debug, category: .planning, message: "Join sending command: %@", args: String(describing: command))
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
        Log.log(level: .error, category: .planning, message: "Join executing error state: %@-%@", args: code, description)
        let planningError = PlanningLandingError(code: code, description: description)
        self.state = .error(planningError)
    }
    
    private func executeCommand(_ command: PlanningCommands.JoinReceive) {
        Log.log(level: .debug, category: .planning, message: "Join executing received command: %{private}@", args: String(describing: command))
        switch command {
        case .noneState(let message):
            state = .none
            parseStateMessage(message)
        case .votingState(let message):
            state = .voting
            parseStateMessage(message)
        case .finishedState(let message):
            state = .finishedVoting
            parseStateMessage(message)
        case .invalidCommand(let message):
            executeError(code: message.code, description: message.description)
        case .invalidSession:
            let errorCode = NSLocalizedString("PLANNING_INVALID_SESSION_ERROR_CODE", comment: "0001")
            let errorDescription = NSLocalizedString("PLANNING_INVALID_SESSION_ERROR_DESCRIPTION", comment: "Invalid session error description")
            executeError(code: errorCode, description: errorDescription)
        case .removeParticipant:
            break
        case .endSession:
            break
        }
    }
    
    private func parseStateMessage(_ message: PlanningSessionStateMessage) {
        self.participants = message.participants
        self.sessionCode = message.sessionCode
        self.sessionName = message.sessionName
        self.ticket = message.ticket
        self.availableCards = message.availableCards
        
        for participant in self.participants {
            participant.selectedCard = ticket?.ticketVotes.first(where: { $0.user.id == participant.id })?.selectedCard
        }
    }
}
