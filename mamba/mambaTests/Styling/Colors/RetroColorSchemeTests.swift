//
//  RetroColorSchemeTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/24.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class RetroColorSchemeTests: XCTestCase {
    var serviceUnderTest: RetroColorScheme!
    
    override func setUpWithError() throws {
        serviceUnderTest = RetroColorScheme()
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
        XCTAssertEqual(red, 65 / 255)
        XCTAssertEqual(green, 211 / 255)
        XCTAssertEqual(blue, 189 / 255)
    }

    func testSecondaryColor() {
        // When: the secondary colour is mapped
        let color = serviceUnderTest.secondary()
        
        var red, green, blue : CGFloat
        (red, green, blue) = (0.0, 0.0, 0.0)
        
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        // Then: the red, green and blue match expected values
        XCTAssertEqual(red, 44 / 255)
        XCTAssertEqual(green, 66 / 255)
        XCTAssertEqual(blue, 81 / 255)
    }
    
    func testTertiaryColor() {
        // When: the tertiary colour is mapped
        let color = serviceUnderTest.tertiary()
        
        var red, green, blue : CGFloat
        (red, green, blue) = (0.0, 0.0, 0.0)
        
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        // Then: the red, green and blue match expected values
        XCTAssertEqual(red, 209 / 255)
        XCTAssertEqual(green, 214 / 255)
        XCTAssertEqual(blue, 70 / 255)
    }
    
    func testQauternaryColor() {
        // When: the qauternary colour is mapped
        let color = serviceUnderTest.qauternary()
        
        var red, green, blue : CGFloat
        (red, green, blue) = (0.0, 0.0, 0.0)
        
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        // Then: the red, green and blue match expected values
        XCTAssertEqual(red, 162 / 255)
        XCTAssertEqual(green, 132 / 255)
        XCTAssertEqual(blue, 151 / 255)
    }
    
    func testQuinaryColor() {
        // When: the quinary colour is mapped
        let color = serviceUnderTest.quinary()
        
        var red, green, blue : CGFloat
        (red, green, blue) = (0.0, 0.0, 0.0)
        
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        // Then: the red, green and blue match expected values
        XCTAssertEqual(red, 64 / 255)
        XCTAssertEqual(green, 120 / 255)
        XCTAssertEqual(blue, 153 / 255)
    }
    
    func testAccentColor() {
        // When: the accent colour is mapped
        let color = serviceUnderTest.accent()
        
        // Then: the accent colour matches the expected existing colour
        XCTAssertEqual(color, serviceUnderTest.primary())
    }
    
}
