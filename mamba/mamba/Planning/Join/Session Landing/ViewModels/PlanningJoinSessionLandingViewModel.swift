//
//  PlanningJoinSessionLandingView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

class PlanningJoinSessionLandingViewModel: PlanningSessionLandingViewModel<PlanningCommands.JoinSend, PlanningCommands.JoinReceive> {
    private var cancellable: AnyCancellable?
    
    init(sessionCode: String, participantName: String) {
        super.init(websocketURL: URLCenter.shared.planningJoinWSURL)
        configure(sessionCode: sessionCode)
        configure(participantName: participantName)
        
        cancellable = $selectedCard.sink { selectedCard in
            guard let card = selectedCard else { return }
            self.sendVoteCommand(card)
        }
    }
    
    func sendJoinSessionCommand() {
        let commandMessage = PlanningJoinSessionMessage(sessionCode: sessionCode, participantName: participantName)
        sendCommand(.joinSession(commandMessage))
    }
    
    private func sendVoteCommand(_ selectedCard: PlanningCard) {
        guard let ticketId = ticket?.identifier else { return }
        let commandMessage = PlanningVoteMessage(ticketId: ticketId, selectedCard: selectedCard)
        sendCommand(.vote(commandMessage))
    }
    
    public override func executeCommand(_ command: PlanningCommands.JoinReceive) {
        super.executeCommand(command)
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

}
