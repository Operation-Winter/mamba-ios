//
//  LogLevel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import os

public enum LogLevel {
    case `default`
    case info
    case error
    case fault
    case debug
    
    var type: OSLogType {
        switch self {
        case .default: return OSLogType.default
        case .info: return OSLogType.info
        case .error: return OSLogType.error
        case .fault: return OSLogType.fault
        case .debug: return OSLogType.debug
        }
    }
}
