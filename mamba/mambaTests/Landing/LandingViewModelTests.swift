//
//  LandingViewModelTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/24.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class LandingViewModelTests: XCTestCase {

    func testLandingItems() {
        // When: landing items are mapped
        let landingItems = LandingViewModel().landingItems
        
        // Then: The mapped values match expected values
        XCTAssertEqual(landingItems.count, 2)
        XCTAssertEqual(landingItems.element(at: 0), LandingItem.planningHost)
        XCTAssertEqual(landingItems.element(at: 1), LandingItem.planningJoin)
    }
    
    func testChunkedLandingItems() {
        // When: chunked landing items are mapped
        let landingItems = LandingViewModel().chunkedLandingItems
        
        // Then: The mapped values match expected values
        XCTAssertEqual(landingItems.count, 1)
        XCTAssertEqual(landingItems.element(at: 0)?.count, 2)
        XCTAssertEqual(landingItems.element(at: 0)?.element(at: 0), LandingItem.planningHost)
        XCTAssertEqual(landingItems.element(at: 0)?.element(at: 1), LandingItem.planningJoin)
    }

}
