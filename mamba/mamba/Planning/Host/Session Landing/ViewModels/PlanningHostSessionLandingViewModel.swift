//
//  PlanningHostSessionLandingViewModel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine
import MambaNetworking

class PlanningHostSessionLandingViewModel: PlanningSessionLandingViewModel<PlanningCommands.HostServerReceive, PlanningCommands.HostServerSend> {
    @Published var showInitialShareModal: Bool = false
    @Published var autoCompleteVoting: Bool = true
    
    var revoteDisabled: Bool {
        if case .finishedVoting = state {
            return false
        }
        return true
    }
    
    var finishVotingVisible: Bool {
        if case .voting = state {
            return true
        }
        return false
    }
    
    init(sessionName: String, autoCompleteVoting: Bool, availableCards: [PlanningCard]) {
        super.init(websocketURL: URLCenter.shared.planningHostWSURL)
        self.autoCompleteVoting = autoCompleteVoting
        commonInit(sessionName: sessionName, availableCards: availableCards)
    }
    
    init(sessionName: String, availableCards: [PlanningCard], service: PlanningSessionLandingService<PlanningCommands.HostServerReceive, PlanningCommands.HostServerSend>) {
        super.init(service: service)
        commonInit(sessionName: sessionName, availableCards: availableCards)
    }
    
    private func commonInit(sessionName: String, availableCards: [PlanningCard]) {
        self.sessionName = sessionName
        configure(availableCards: availableCards)
    }
    
    func sendStartSessionCommand() {
        let commandMessage = PlanningStartSessionMessage(sessionName: sessionName, autoCompleteVoting: autoCompleteVoting, availableCards: availableCards)
        sendCommand(.startSession(uuid: uuid, message: commandMessage))
    }
    
    func sendAddTicketCommand(title: String, description: String) {
        let commandMessage = PlanningTicketMessage(title: title, description: description)
        sendCommand(.addTicket(uuid: uuid, message: commandMessage))
    }
    
    func sendRevoteTicketCommand() {
        sendCommand(.revote(uuid: uuid))
    }
    
    func sendEndSessionCommand() {
        sendCommand(.endSession(uuid: uuid))
        closeSession()
    }
    
    func sendFinishVotingCommand() {
        sendCommand(.finishVoting(uuid: uuid))
    }
    
    func sendSkipParticipantVoteCommand(participantId: UUID) {
        let commandMessage = PlanningSkipVoteMessage(participantId: participantId)
        sendCommand(.skipVote(uuid: uuid, message: commandMessage))
    }
    
    func sendRemoveParticipantCommand(participantId: UUID) {
        let commandMessage = PlanningRemoveParticipantMessage(participantId: participantId)
        sendCommand(.removeParticipant(uuid: uuid, message: commandMessage))
    }
    
    public override func executeCommand(_ command: PlanningCommands.HostServerSend) {
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
        case .previousTickets(_):
            // TODO: Implement what to do with previous tickets command
            break
        }
    }
    
    override func connectionSuccessful() {
        super.connectionSuccessful()
        sendStartSessionCommand()
    }
}
