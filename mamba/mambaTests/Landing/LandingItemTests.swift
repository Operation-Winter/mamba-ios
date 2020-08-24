//
//  LandingItemTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/24.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
import SwiftUI
@testable import Mamba

class LandingItemTests: XCTestCase {

    func testImageNames() {
        // Then: the image names match the expected values
        for (index, item) in LandingItem.allCases.enumerated() {
            XCTAssertEqual(item.imageName, Expected.imageNames.element(at: index))
        }
    }
    
    func testTitleKey() {
        // Then: the title keys match the expected values
        for (index, item) in LandingItem.allCases.enumerated() {
            XCTAssertEqual(item.titleKey, Expected.titleKeys.element(at: index))
        }
    }

}

fileprivate class Expected {
    static let imageNames = [
        "PlanningHost",
        "PlanningJoin",
        "RetroHost",
        "RetroJoin"
    ]
    
    static let titleKeys = [
        LocalizedStringKey("LANDING_PLANNING_HOST"),
        LocalizedStringKey("LANDING_PLANNING_JOIN"),
        LocalizedStringKey("LANDING_RETRO_HOST"),
        LocalizedStringKey("LANDING_RETRO_JOIN")
    ]
}
