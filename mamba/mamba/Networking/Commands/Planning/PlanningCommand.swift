//
//  PlanningCommand.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public enum PlanningCommands {
    public enum HostKey: String {
        // MARK: - Planning Host Send
        case startSession = "START_SESSION"
        case addTicket = "ADD_TICKET"
        case skipVote = "SKIP_VOTE"
        case removeParticipant = "REMOVE_PARTICIPANT"
        case endSession = "END_SESSION"
        case finishVoting = "FINISH_VOTING"
        case reconnect = "RECONNECT"
        
        // MARK: - Planning Host Receive
        case noneState = "NONE_STATE"
        case votingState = "VOTING_STATE"
        case finishedState = "FINISHED_STATE"
        case invalidCommand = "INVALID_COMMAND"
    }

    public enum HostSend: Codable {
        case startSession(StartSessionMessage)
        case addTicket
        case skipVote
        case removeParticipant
        case endSession
        case finishVoting
        case reconnect
    }
    
    public enum HostReceive: Codable {
        case noneState
        case votingState
        case finishedState
        case invalidCommand
    }
}
