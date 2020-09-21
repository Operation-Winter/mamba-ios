//
//  PlanningHostSessionLandingViewModel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

class PlanningHostSessionLandingViewModel: PlanningSessionLandingViewModel<PlanningCommands.HostSend, PlanningCommands.HostReceive> {
    @Published var showInitialShareModal: Bool = false
    
    var revoteDisabled: Bool {
        if case .finishedVoting = state {
            return false
        }
        return true
    }
    
    var finishVotingVisible: Bool {
        if case .voting = state {
            return false
        }
        return true
    }
    
    init(sessionName: String, availableCards: [PlanningCard]) {
        super.init(websocketURL: URLCenter.shared.planningHostWSURL)
        commonInit(sessionName: sessionName, availableCards: availableCards)
    }
    
    init(sessionName: String, availableCards: [PlanningCard], service: PlanningSessionLandingService<PlanningCommands.HostSend, PlanningCommands.HostReceive>) {
        super.init(service: service)
        commonInit(sessionName: sessionName, availableCards: availableCards)
    }
    
    private func commonInit(sessionName: String, availableCards: [PlanningCard]) {
        self.sessionName = sessionName
        configure(availableCards: availableCards)
    }
    
    func sendStartSessionCommand() {
        let commandMessage = PlanningStartSessionMessage(sessionName: sessionName, availableCards: availableCards)
        sendCommand(.startSession(commandMessage))
    }
    
    func sendAddTicketCommand(identifier: String, description: String) {
        let commandMessage = PlanningAddTicketMessage(identifier: identifier, description: description)
        sendCommand(.addTicket(commandMessage))
    }
    
    func sendRevoteTicketCommand() {
        sendCommand(.revote)
    }
    
    func sendEndSessionCommand() {
        sendCommand(.endSession)
        closeSession()
    }
    
    func sendFinishVotingCommand() {
        sendCommand(.finishVoting)
    }
    
    func sendSkipParticipantVoteCommand(participantId: String) {
        let commandMessage = PlanningSkipVoteMessage(participantId: participantId)
        sendCommand(.skipVote(commandMessage))
    }
    
    func sendRemoveParticipantCommand(participantId: String) {
        let commandMessage = PlanningRemoveParticipantMessage(participantId: participantId)
        sendCommand(.removeParticipant(commandMessage))
    }
    
    public override func executeCommand(_ command: PlanningCommands.HostReceive) {
        super.executeCommand(command)
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
}
