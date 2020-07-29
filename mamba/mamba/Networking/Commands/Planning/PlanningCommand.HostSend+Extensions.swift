//
//  PlanningCommands.HostSend+Extensions.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public extension PlanningCommands.HostSend {
    private enum CodingKeys: String, CodingKey {
        case type
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case PlanningCommands.HostKey.addTicket.rawValue:
            self = .addTicket
        case PlanningCommands.HostKey.endSession.rawValue:
            self = .endSession
        case PlanningCommands.HostKey.finishVoting.rawValue:
            self = .finishVoting
        case PlanningCommands.HostKey.reconnect.rawValue:
            self = .reconnect
        case PlanningCommands.HostKey.removeParticipant.rawValue:
            self = .removeParticipant
        case PlanningCommands.HostKey.skipVote.rawValue:
            self = .skipVote
        case PlanningCommands.HostKey.startSession.rawValue:
            let model = try container.decode(StartSessionMessage.self, forKey: .message)
            self = .startSession(model)
        default:
            throw DecodingError.keyNotFound(CodingKeys.message, DecodingError.Context(codingPath: [], debugDescription: "Invalid key: \(type)"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.rawValue, forKey: .type)
        
        switch self {
        case .startSession(let message): try container.encode(message, forKey: .message)
        default: try container.encodeNil(forKey: .message)
        }
    }
    
    var rawValue: String {
        switch self {
        case .startSession(_): return PlanningCommands.HostKey.startSession.rawValue
        case .addTicket: return PlanningCommands.HostKey.addTicket.rawValue
        case .skipVote: return PlanningCommands.HostKey.skipVote.rawValue
        case .removeParticipant: return PlanningCommands.HostKey.removeParticipant.rawValue
        case .endSession: return PlanningCommands.HostKey.endSession.rawValue
        case .finishVoting: return PlanningCommands.HostKey.finishVoting.rawValue
        case .reconnect: return PlanningCommands.HostKey.reconnect.rawValue
        }
    }
}
