//
//  PlanningCommands.HostReceive+Extensions.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public extension PlanningCommands.HostReceive {
    private enum CodingKeys: String, CodingKey {
        case type
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case PlanningCommands.HostKey.newParticipant.rawValue:
            self = .newParticipant
        case PlanningCommands.HostKey.removeParticipant.rawValue:
            self = .removeParticipant
        case PlanningCommands.HostKey.participantList.rawValue:
            self = .participantList
        case PlanningCommands.HostKey.votingFinished.rawValue:
            self = .votingFinished
        case PlanningCommands.HostKey.ticketVote.rawValue:
            self = .ticketVote
        case PlanningCommands.HostKey.shareSession.rawValue:
            self = .shareSession
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
    
    var rawValue: String {
        switch self {
        case .newParticipant: return PlanningCommands.HostKey.newParticipant.rawValue
        case .removeParticipant: return PlanningCommands.HostKey.removeParticipant.rawValue
        case .participantList: return PlanningCommands.HostKey.participantList.rawValue
        case .votingFinished: return PlanningCommands.HostKey.votingFinished.rawValue
        case .ticketVote: return PlanningCommands.HostKey.ticketVote.rawValue
        case .shareSession: return PlanningCommands.HostKey.shareSession.rawValue
        }
    }
}
