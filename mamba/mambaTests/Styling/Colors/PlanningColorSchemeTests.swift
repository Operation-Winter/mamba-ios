//
//  PlanningColorSchemeTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/24.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class PlanningColorSchemeTests: XCTestCase {
    var serviceUnderTest: PlanningColorScheme!
    
    override func setUpWithError() throws {
        serviceUnderTest = PlanningColorScheme()
    }

    override func tearDownWithError() throws {
        serviceUnderTest = nil
    }

    func testPrimaryColor() {
        // When: the primary colour is mapped
        let color = serviceUnderTest.primary()
        
        var red, green, blue : CGFloat
        (red, green, blue) = (0.0, 0.0, 0.0)
        
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        // Then: the red, green and blue match expected values
        XCTAssertEqual(red, 56 / 255)
        XCTAssertEqual(green, 2 / 255)
        XCTAssertEqual(blue, 59 / 255)
    }
    
    func testSecondaryColor() {
        // When: the secondary colour is mapped
        let color = serviceUnderTest.secondary()
        
        var red, green, blue : CGFloat
        (red, green, blue) = (0.0, 0.0, 0.0)
        
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        // Then: the red, green and blue match expected values
        XCTAssertEqual(red, 162 / 255)
        XCTAssertEqual(green, 136 / 255)
        XCTAssertEqual(blue, 227 / 255)
    }
    
    func testTertiaryColor() {
        // When: the tertiary colour is mapped
        let color = serviceUnderTest.tertiary()
        
        var red, green, blue : CGFloat
        (red, green, blue) = (0.0, 0.0, 0.0)
        
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        // Then: the red, green and blue match expected values
        XCTAssertEqual(red, 187 / 255)
        XCTAssertEqual(green, 213 / 255)
        XCTAssertEqual(blue, 237 / 255)
    }
    
    func testQauternaryColor() {
        // When: the qauternary colour is mapped
        let color = serviceUnderTest.qauternary()
        
        var red, green, blue : CGFloat
        (red, green, blue) = (0.0, 0.0, 0.0)
        
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        // Then: the red, green and blue match expected values
        XCTAssertEqual(red, 206 / 255)
        XCTAssertEqual(green, 253 / 255)
        XCTAssertEqual(blue, 255 / 255)
    }
    
    func testQuinaryColor() {
        // When: the quinary colour is mapped
        let color = serviceUnderTest.quinary()
        
        var red, green, blue : CGFloat
        (red, green, blue) = (0.0, 0.0, 0.0)
        
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        // Then: the red, green and blue match expected values
        XCTAssertEqual(red, 204 / 255)
        XCTAssertEqual(green, 255 / 255)
        XCTAssertEqual(blue, 203 / 255)
    }
    
    func testAccentColor() {
        // When: the accent colour is mapped
        let color = serviceUnderTest.accent()

        // Then: the accent colour matches the expected existing colour
        XCTAssertEqual(color, serviceUnderTest.secondary())
    }

}
