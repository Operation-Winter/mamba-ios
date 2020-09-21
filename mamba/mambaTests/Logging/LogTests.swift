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

    func testRawValues() {
        // Then: the rawValues of each enum case match expected value
        XCTAssertEqual(Log.logging.rawValue, "logging")
        XCTAssertEqual(Log.networking.rawValue, "networking")
        XCTAssertEqual(Log.planning.rawValue, "planning")
        XCTAssertEqual(Log.retro.rawValue, "retro")
    }

}
