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
    
    init(sessionName: String, availableCards: [PlanningCard]) {
        self.service = PlanningHostSessionLandingService()
        self.sessionName = sessionName
        self.availableCards = availableCards
        startSession()
    }
    
    func sendStartSessionCommand() {
        let commandMessage = PlanningStartSessionMessage(sessionName: sessionName, availableCards: availableCards)
        try? service.sendCommand(.startSession(commandMessage))
        //TODO: MAM-28 Exception handling
    }
    
    func sendAddTicketCommand(identifier: String, description: String) {
        let commandMessage = PlanningAddTicketMessage(identifier: identifier, description: description)
        try? service.sendCommand(.addTicket(commandMessage))
        //TODO: MAM-28 Exception handling
    }
    
    private func startSession() {
        guard cancellable == nil else { return }
        cancellable = service.startSession()
            .subscribe(on: DispatchQueue.global(qos: .background))
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
    
    private func executeCommand(_ command: PlanningCommands.HostReceive) {
        //TODO: Logging
        print(command)
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
            self.state = .error(PlanningLandingError(code: message.code, description: message.description))
        }
    }
    
    private func parseStateMessage(_ message: PlanningSessionStateMessage) {
        self.participants = message.participants
        self.sessionCode = message.sessionCode
        self.sessionName = message.sessionName
        self.ticket = message.ticket
    }
}
