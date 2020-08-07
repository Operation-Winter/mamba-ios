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
        let commandMessage = StartSessionMessage(sessionName: sessionName, availableCards: availableCards)
        try? service.sendCommand(.startSession(commandMessage))
        //TODO: MAM-28 Exception handling
    }
    
    func sendAddTicketCommand(identifier: String, description: String) {
        let commandMessage = AddTicketMessage(identifier: identifier, description: description)
        try? service.sendCommand(.addTicket(commandMessage))
        //TODO: MAM-28 Exception handling
    }
    
    private func startSession() {
        guard cancellable == nil else { return }
        cancellable = service.startSession()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { networkError in
                print(networkError)
                self.state = .error
                //TODO: MAM-28
            }, receiveValue: { result in
                switch result {
                case .success(let command):
                    self.executeCommand(command)
                case .failure(let error):
                    print(error)
                    self.state = .error
                    //TODO: MAM-28
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
        case .invalidCommand:
            self.state = .error
            //TODO: MAM-28
        }
    }
    
    private func parseStateMessage(_ message: PlanningSessionStateMessage) {
        self.participants = message.participants
        self.sessionCode = message.sessionCode
        self.sessionName = message.sessionName
        self.ticket = message.ticket
    }
}
