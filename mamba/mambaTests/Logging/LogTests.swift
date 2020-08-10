//
//  LogTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class LogTests: XCTestCase {

    func testLogSubsystem() throws {
        // When: get log subsystem
        let subsystem = Log.subsystem
        
        // Then: log subsystem matches expected value
        XCTAssertEqual(subsystem, "za.co.armandkamffer.mamba")
    }

}
