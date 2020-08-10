//
//  LogLevelTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
import os.log
@testable import Mamba

class LogLevelTests: XCTestCase {

    func testDefaultLevelOSLogType() {
        // When: LogLevel default type value if fetched
        let logType = LogLevel.default.type
        
        // Then: The LogLevel matched default OSLogType value
        XCTAssertEqual(logType, OSLogType.default)
    }
    
    func testDebugLevelOSLogType() {
        // When: LogLevel debug type value if fetched
        let logType = LogLevel.debug.type
        
        // Then: The LogLevel matched debug OSLogType value
        XCTAssertEqual(logType, OSLogType.debug)
    }
    
    func testErrorLevelOSLogType() {
        // When: LogLevel error type value if fetched
        let logType = LogLevel.error.type
        
        // Then: The LogLevel matched error OSLogType value
        XCTAssertEqual(logType, OSLogType.error)
    }
    
    func testFaultLevelOSLogType() {
        // When: LogLevel fault type value if fetched
        let logType = LogLevel.fault.type
        
        // Then: The LogLevel matched fault OSLogType value
        XCTAssertEqual(logType, OSLogType.fault)
    }
    
    func testInfoLevelOSLogType() {
        // When: LogLevel info type value if fetched
        let logType = LogLevel.info.type
        
        // Then: The LogLevel matched info OSLogType value
        XCTAssertEqual(logType, OSLogType.info)
    }

}
