//
//  PlanningCommand.JoinReceive+Extensions.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/31.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public extension PlanningCommands.JoinReceive {
    private enum CodingKeys: String, CodingKey {
        case type
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case PlanningCommands.JoinKey.noneState.rawValue:
            let model = try container.decode(PlanningSessionStateMessage.self, forKey: .message)
            self = .noneState(model)
        case PlanningCommands.JoinKey.votingState.rawValue:
            let model = try container.decode(PlanningSessionStateMessage.self, forKey: .message)
            self = .votingState(model)
        case PlanningCommands.JoinKey.finishedState.rawValue:
            let model = try container.decode(PlanningSessionStateMessage.self, forKey: .message)
            self = .finishedState(model)
        case PlanningCommands.JoinKey.invalidCommand.rawValue:
            let model = try container.decode(PlanningInvalidCommandMessage.self, forKey: .message)
            self = .invalidCommand(model)
        case PlanningCommands.JoinKey.invalidSession.rawValue:
            self = .invalidSession
        case PlanningCommands.JoinKey.removeParticipant.rawValue:
            self = .removeParticipant
        case PlanningCommands.JoinKey.endSession.rawValue:
            self = .endSession
        default:
            throw DecodingError.keyNotFound(CodingKeys.message, DecodingError.Context(codingPath: [], debugDescription: "Invalid key: \(type)"))
        }
    }
    
    var rawValue: String {
        switch self {
        case .noneState(_): return PlanningCommands.JoinKey.noneState.rawValue
        case .votingState(_): return PlanningCommands.JoinKey.votingState.rawValue
        case .finishedState(_): return PlanningCommands.JoinKey.finishedState.rawValue
        case .invalidCommand: return PlanningCommands.JoinKey.invalidCommand.rawValue
        case .invalidSession: return PlanningCommands.JoinKey.invalidSession.rawValue
        case .removeParticipant: return PlanningCommands.JoinKey.removeParticipant.rawValue
        case .endSession: return PlanningCommands.JoinKey.endSession.rawValue
        }
    }
}
