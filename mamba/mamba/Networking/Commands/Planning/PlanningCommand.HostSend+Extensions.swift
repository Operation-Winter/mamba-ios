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
        case PlanningCommands.HostKey.setupSession.rawValue:
            let model = try container.decode(SetupSessionMessage.self, forKey: .message)
            self = .setupSession(model)
        case PlanningCommands.HostKey.addTicket.rawValue:
            self = .addTicket
        case PlanningCommands.HostKey.skipVote.rawValue:
            self = .skipVote
        case PlanningCommands.HostKey.removeUser.rawValue:
            self = .removeUser
        case PlanningCommands.HostKey.endSession.rawValue:
            self = .endSession
        case PlanningCommands.HostKey.finishVoting.rawValue:
            self = .finishVoting
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
        case .setupSession(let message): try container.encode(message, forKey: .message)
        default: try container.encodeNil(forKey: .message)
        }
    }
    
    var rawValue: String {
        switch self {
        case .setupSession(_): return PlanningCommands.HostKey.setupSession.rawValue
        case .addTicket: return PlanningCommands.HostKey.addTicket.rawValue
        case .skipVote: return PlanningCommands.HostKey.skipVote.rawValue
        case .removeUser: return PlanningCommands.HostKey.removeUser.rawValue
        case .endSession: return PlanningCommands.HostKey.endSession.rawValue
        case .finishVoting: return PlanningCommands.HostKey.finishVoting.rawValue
        case .shareSession: return PlanningCommands.HostKey.shareSession.rawValue
        }
    }
}
