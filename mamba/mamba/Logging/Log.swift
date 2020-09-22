//
//  Log.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import os

public enum Log: String {
    case logging = "logging"
    case networking = "networking"
    case planning = "planning"
    case retro = "retro"
    
    private static var subsystem: String {
        guard let subsystem = Bundle.main.bundleIdentifier else {
            fatalError("Failed to fetch bundleIdentifier")
        }
        return subsystem
    }
    
    private static let networkingLog = Logger(subsystem: subsystem, category: Log.networking.rawValue)
    private static let planningLog = Logger(subsystem: subsystem, category: Log.planning.rawValue)
    private static let retroLog = Logger(subsystem: subsystem, category: Log.retro.rawValue)
    private static let loggingLog = Logger(subsystem: subsystem, category: Log.logging.rawValue)
    
    var logger: Logger {
        switch self {
        case .networking: return Log.networkingLog
        case .planning: return Log.planningLog
        case .retro: return Log.retroLog
        case .logging: return Log.loggingLog
        }
    }
}
