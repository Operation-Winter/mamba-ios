//
//  LogCategory.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import os

public enum LogCategory: String {
    case logging = "logging"
    case networking = "networking"
    case planning = "planning"
    case retro = "retro"
    
    private static let networkingLog = OSLog(subsystem: Log.subsystem, category: LogCategory.networking.rawValue)
    private static let planningLog = OSLog(subsystem: Log.subsystem, category: LogCategory.planning.rawValue)
    private static let retroLog = OSLog(subsystem: Log.subsystem, category: LogCategory.retro.rawValue)
    private static let loggingLog = OSLog(subsystem: Log.subsystem, category: LogCategory.logging.rawValue)
    
    var log: OSLog {
        switch self {
        case .networking: return LogCategory.networkingLog
        case .planning: return LogCategory.planningLog
        case .retro: return LogCategory.retroLog
        case .logging: return LogCategory.loggingLog
        }
    }
}
