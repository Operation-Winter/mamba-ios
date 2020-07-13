//
//  PlanningJoinCommands.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

enum PlanningJoinCommand: Codable {
    // MARK: - Planning Host Receive
    case newParticipant
    case removeParticipant
    case participantList
    case votingFinished
    case ticketVote
    
    // MARK: - Planning Host Send/Receive
    case shareSession
}

extension PlanningJoinCommand {
    private enum CodingKeys: String, CodingKey {
        case type
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "NEW_PARTICIPANT": self = .newParticipant
        case "REMOVE_PARTICIPANT": self = .removeParticipant
        case "PARTICIPANT_LIST": self = .participantList
        case "VOTING_FINISHED": self = .votingFinished
        case "TICKET_VOTE": self = .ticketVote
        case "SHARE_SESSION": self = .shareSession
        default:
            throw DecodingError.keyNotFound(CodingKeys.message, DecodingError.Context(codingPath: [], debugDescription: "Invalid key: \(type)"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.rawValue, forKey: .type)
        
        switch self {
        default: try container.encodeNil(forKey: .message)
        }
    }
    
    public var rawValue: String {
        switch self {
        // MARK: Planning Host Receive
        case .newParticipant: return "NEW_PARTICIPANT"
        case .removeParticipant: return "REMOVE_PARTICIPANT"
        case .participantList: return "PARTICIPANT_LIST"
        case .votingFinished: return "VOTING_FINISHED"
        case .ticketVote: return "TICKET_VOTE"
            
        // MARK: Planning Host Send/Receive
        case .shareSession: return "SHARE_SESSION"
        }
    }
}
