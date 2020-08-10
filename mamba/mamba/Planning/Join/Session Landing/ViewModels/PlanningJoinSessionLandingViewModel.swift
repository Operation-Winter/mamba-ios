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
    @Published var selectedCard: PlanningCard?
    
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
    
    func sendCommand(_ command: PlanningCommands.JoinSend) {
        do {
            try service.sendCommand(command)
        } catch let error as EncodingError {
            state = .error(PlanningLandingError(code: error.errorCode, description: error.errorCustomDescription))
        } catch {
            state = .error(PlanningLandingError(code: "3105", description: error.localizedDescription))
        }
    }
    
    private func startSession() {
        guard cancellable == nil else { return }
        cancellable = service.startSession()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { networkError in
                switch networkError {
                case .finished:
                    //TODO: Socket closed clientside, dismiss view?
                    break
                case .failure(let error):
                    let planningError = PlanningLandingError(code: error.errorCode, description: error.errorDescription)
                    self.state = .error(planningError)
                }
            }, receiveValue: { result in
                switch result {
                case .success(let command):
                    self.executeCommand(command)
                case .failure(let error):
                    let planningError = PlanningLandingError(code: error.errorCode, description: error.errorDescription)
                    self.state = .error(planningError)
                }
            })
    }
    
    private func executeCommand(_ command: PlanningCommands.JoinReceive) {
        //TODO: Logging
        print(command)
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
            self.state = .error(PlanningLandingError(code: message.code, description: message.description))
        case .invalidSession:
            let errorCode = NSLocalizedString("PLANNING_INVALID_SESSION_ERROR_CODE", comment: "0001")
            let errorDescription = NSLocalizedString("PLANNING_INVALID_SESSION_ERROR_DESCRIPTION", comment: "Invalid session error description")
            self.state = .error(PlanningLandingError(code: errorCode, description: errorDescription))
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
    }
}
