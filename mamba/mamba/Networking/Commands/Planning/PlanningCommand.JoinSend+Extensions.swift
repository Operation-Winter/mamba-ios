//
//  PlanningCommand.JoinSend+Extensions.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/31.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public extension PlanningCommands.JoinSend {
    private enum CodingKeys: String, CodingKey {
        case type
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case PlanningCommands.JoinKey.joinSession.rawValue:
            let model = try container.decode(JoinSessionMessage.self, forKey: .message)
            self = .joinSession(model)
        case PlanningCommands.JoinKey.vote.rawValue:
            self = .vote
        case PlanningCommands.JoinKey.leaveSession.rawValue:
            self = .leaveSession
        case PlanningCommands.JoinKey.reconnect.rawValue:
            self = .reconnect
        default:
            throw DecodingError.keyNotFound(CodingKeys.message, DecodingError.Context(codingPath: [], debugDescription: "Invalid key: \(type)"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.rawValue, forKey: .type)
        
        switch self {
        case .joinSession(let message): try container.encode(message, forKey: .message)
        default: try container.encodeNil(forKey: .message)
        }
    }
    
    var rawValue: String {
        switch self {
        case .joinSession(_): return PlanningCommands.JoinKey.joinSession.rawValue
        case .vote: return PlanningCommands.JoinKey.vote.rawValue
        case .leaveSession: return PlanningCommands.JoinKey.leaveSession.rawValue
        case .reconnect: return PlanningCommands.JoinKey.reconnect.rawValue
        }
    }
}
