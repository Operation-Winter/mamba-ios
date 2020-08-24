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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.rawValue, forKey: .type)
        
        switch self {
        case .startSession(let message): try container.encode(message, forKey: .message)
        case .addTicket(let message): try container.encode(message, forKey: .message)
        case .skipVote(let message): try container.encode(message, forKey: .message)
        case .removeParticipant(let message): try container.encode(message, forKey: .message)
        default:
            break
        }
    }
    
    var rawValue: String {
        switch self {
        case .startSession(_):
            return PlanningCommands.HostKey.startSession.rawValue
        case .addTicket:
            return PlanningCommands.HostKey.addTicket.rawValue
        case .skipVote:
            return PlanningCommands.HostKey.skipVote.rawValue
        case .removeParticipant:
            return PlanningCommands.HostKey.removeParticipant.rawValue
        case .endSession:
            return PlanningCommands.HostKey.endSession.rawValue
        case .finishVoting:
            return PlanningCommands.HostKey.finishVoting.rawValue
        case .reconnect:
            return PlanningCommands.HostKey.reconnect.rawValue
        case .revote:
            return PlanningCommands.HostKey.revote.rawValue
        }
    }
}
