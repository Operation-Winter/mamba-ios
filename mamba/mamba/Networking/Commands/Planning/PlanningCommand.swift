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
        case setupSession = "SETUP_SESSION"
        case addTicket = "ADD_TICKET"
        case skipVote = "SKIP_VOTE"
        case removeUser = "REMOVE_USER"
        case endSession = "END_SESSION"
        case finishVoting = "FINISH_VOTING"
        
        // MARK: - Planning Host Receive
        case newParticipant = "NEW_PARTICIPANT"
        case removeParticipant = "REMOVE_PARTICIPANT"
        case participantList = "PARTICIPANT_LIST"
        case votingFinished = "VOTING_FINISHED"
        case ticketVote = "TICKET_VOTE"
        
        // MARK: - Planning Host Send/Receive
        case shareSession = "SHARE_SESSION"
    }

    public enum HostSend: Codable {
        case setupSession(SetupSessionCommand)
        case addTicket
        case skipVote
        case removeUser
        case endSession
        case finishVoting
        case shareSession
    }
    
    public enum HostReceive: Codable {
        case newParticipant
        case removeParticipant
        case participantList
        case votingFinished
        case ticketVote
        case shareSession
    }
}
