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
        case PlanningCommands.HostKey.noneState.rawValue:
            self = .noneState
        case PlanningCommands.HostKey.votingState.rawValue:
            self = .votingState
        case PlanningCommands.HostKey.finishedState.rawValue:
            self = .finishedState
        case PlanningCommands.HostKey.invalidCommand.rawValue:
            self = .invalidCommand
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
        case .noneState: return PlanningCommands.HostKey.noneState.rawValue
        case .votingState: return PlanningCommands.HostKey.votingState.rawValue
        case .finishedState: return PlanningCommands.HostKey.finishedState.rawValue
        case .invalidCommand: return PlanningCommands.HostKey.invalidCommand.rawValue
        }
    }
}
