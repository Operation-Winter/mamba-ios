//
//  PlanningHostCommands.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public enum PlanningHostCommand: Codable {
    // MARK: - Planning Host Send
    case setupSession(SetupSessionCommand)
    case addTicket
    case skipVote
    case removeUser
    case endSession
    case finishVoting
    
    // MARK: - Planning Host Send/Receive
    case shareSession
}

extension PlanningHostCommand {
    private enum CodingKeys: String, CodingKey {
        case type
        case message
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "SETUP_SESSION":
            let model = try container.decode(SetupSessionCommand.self, forKey: .message)
            self = .setupSession(model)
        case "ADD_TICKET": self = .addTicket
        case "SKIP_VOTE": self = .skipVote
        case "REMOVE_USER": self = .removeUser
        case "END_SESSION": self = .endSession
        case "FINISH_VOTING": self = .finishVoting
        case "SHARE_SESSION": self = .shareSession
        default:
            throw DecodingError.keyNotFound(CodingKeys.message, DecodingError.Context(codingPath: [], debugDescription: "Invalid key: \(type)"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.rawValue, forKey: .type)
        
        switch self {
        case .setupSession(let message): try container.encode(message, forKey: .message)
        default: try container.encodeNil(forKey: .message)
        }
    }
    
    public var rawValue: String {
        switch self {
        // MARK: Planning Host Send
        case .setupSession(_): return "SETUP_SESSION"
        case .addTicket: return "ADD_TICKET"
        case .skipVote: return "SKIP_VOTE"
        case .removeUser: return "REMOVE_USER"
        case .endSession: return "END_SESSION"
        case .finishVoting: return "FINISH_VOTING"

        // MARK: Planning Host Send/Receive
        case .shareSession: return "SHARE_SESSION"
        }
    }
}
