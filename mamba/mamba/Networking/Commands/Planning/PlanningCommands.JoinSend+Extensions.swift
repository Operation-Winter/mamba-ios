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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.rawValue, forKey: .type)
        
        switch self {
        case .joinSession(let message): try container.encode(message, forKey: .message)
        case .vote(let message): try container.encode(message, forKey: .message)
        default:
            break
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
