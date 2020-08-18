//
//  Log.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import os
import Foundation

public struct Log {
    static var subsystem: String {
        guard let subsystem = Bundle.main.bundleIdentifier else {
            log(level: .fault, category: .logging, message: "Failed to fetch bundleIdentifier")
            fatalError("Failed to fetch bundleIdentifier")
        }
        return subsystem
    }

    public static func log(level: LogLevel, category: LogCategory, message: StaticString) {
        os_log(level.type, log: category.log, message)
    }

    public static func log(level: LogLevel, category: LogCategory, message: StaticString, args: CVarArg) {
        let type = level.type
        let log = category.log
        os_log(type, log: log, message, args)
    }
}
