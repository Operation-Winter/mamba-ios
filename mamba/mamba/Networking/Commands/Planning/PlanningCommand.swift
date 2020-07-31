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
        case noneState(PlanningSessionStateMessage)
        case votingState(PlanningSessionStateMessage)
        case finishedState(PlanningSessionStateMessage)
        case invalidCommand
    }
    
    public enum JoinKey: String {
        // MARK: - Planning Join Send
        case joinSession = "JOIN_SESSION"
        case vote = "VOTE"
        case leaveSession = "LEAVE_SESSION"
        case reconnect = "RECONNECT"
        
        // MARK: - Planning Host Receive
        case noneState = "NONE_STATE"
        case votingState = "VOTING_STATE"
        case finishedState = "FINISHED_STATE"
        case invalidCommand = "INVALID_COMMAND"
        case invalidSession = "INVALID_SESSION"
        case removeParticipant = "REMOVE_PARTICIPANT"
        case endSession = "END_SESSION"
    }
    
    public enum JoinSend: Codable {
        case joinSession(JoinSessionMessage)
        case vote
        case leaveSession
        case reconnect
    }
    
    public enum JoinReceive: Codable {
        case noneState(PlanningSessionStateMessage)
        case votingState(PlanningSessionStateMessage)
        case finishedState(PlanningSessionStateMessage)
        case invalidCommand
        case invalidSession
        case removeParticipant
        case endSession
    }
}
