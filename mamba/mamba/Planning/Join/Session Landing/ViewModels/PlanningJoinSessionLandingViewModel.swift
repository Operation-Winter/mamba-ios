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
    @Published var state: PlanningSessionLandingState = .loading
    @Published var sessionName: String = ""
    @Published var participants = [PlanningParticipant]()
    
    init(sessionCode: String, participantName: String) {
        self.service = PlanningJoinSessionLandingService()
        self.sessionCode = sessionCode
        self.participantName = participantName
        
        startSession()
    }
    
    func sendJoinSessionCommand() {
        let commandMessage = JoinSessionMessage(sessionCode: sessionCode, participantName: participantName)
        try? service.sendCommand(.joinSession(commandMessage))
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
        case .invalidCommand:
            //TODO: MAM-28
            self.state = .error
        case .invalidSession:
            //TODO: MAM-28
            self.state = .error
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
    }
}
