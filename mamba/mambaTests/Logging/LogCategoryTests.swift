//
//  LogCategoryTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class LogCategoryTests: XCTestCase {

    func testRawValues() {
        // Then: the rawValues of each enum case match expected value
        XCTAssertEqual(LogCategory.logging.rawValue, "logging")
        XCTAssertEqual(LogCategory.networking.rawValue, "networking")
        XCTAssertEqual(LogCategory.planning.rawValue, "planning")
        XCTAssertEqual(LogCategory.retro.rawValue, "retro")
    }

}
