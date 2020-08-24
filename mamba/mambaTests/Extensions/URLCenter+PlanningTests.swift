//
//  URLCenter+PlanningTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/24.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class URLCenter_PlanningTests: XCTestCase {

    func testPlanningHostWebSocketURL() {
        // When: Planning host WebSocket URL is mapped
        let url = URLCenter.shared.planningHostWSURL
        
        // Then: the URL matches the expected value
        XCTAssertEqual(url.absoluteString, "ws://localhost:8080/planning/host")
    }
    
    func testPlanningJoinURL() {
        // When: Planning join URL is mapped
        let url = URLCenter.shared.planningJoinURL
        
        // Then: the URL matches the expected value
        XCTAssertEqual(url.absoluteString, "http://localhost:8080/planning/join")
    }
    
    func testPlanningJoinURLSessionCode() {
        // When: Planning join URL is mapped with a session code
        let url = URLCenter.shared.planningJoinURL(sessionCode: "000000")
        
        // Then: the URL matches the expected value
        XCTAssertEqual(url.absoluteString, "http://localhost:8080/planning/join/000000")
    }
    
    func testPlanningJoinWebSocketURL() {
        // When: Planning join WebSocket URL is mapped
        let url = URLCenter.shared.planningJoinWSURL
        
        // Then: the URL matches the expected value
        XCTAssertEqual(url.absoluteString, "ws://localhost:8080/planning/join")
    }
    
    func testPlanningJoinSessionCodeSuccess() {
        // Given: A mocked URL
        let mockedUrl = "http://localhost:8080/planning/join/000000"
        
        // When: Map sessionCode from mocked URL
        let sessionCode = URLCenter.shared.planningSessionCode(from: mockedUrl)
        
        // Then: The sessionCode matches the expected value
        XCTAssertEqual(sessionCode, "000000")
    }
    
    func testPlanningJoinSessionCodeFeatureFail() {
        // Given: A mocked URL
        let mockedUrl = "http://localhost:8080/retro/join/000000"
        
        // When: Map sessionCode from mocked URL
        let sessionCode = URLCenter.shared.planningSessionCode(from: mockedUrl)
        
        // Then: The sessionCode returned is nil
        XCTAssertNil(sessionCode)
    }
    
    func testPlanningJoinSessionCodeTypeFail() {
        // Given: A mocked URL
        let mockedUrl = "http://localhost:8080/planning/host/000000"
        
        // When: Map sessionCode from mocked URL
        let sessionCode = URLCenter.shared.planningSessionCode(from: mockedUrl)
        
        // Then: The sessionCode returned is nil
        XCTAssertNil(sessionCode)
    }
    
    func testPlanningJoinSessionCodeSessionCodeFail() {
        // Given: A mocked URL
        let mockedUrl = "http://localhost:8080/planning/join/000"
        
        // When: Map sessionCode from mocked URL
        let sessionCode = URLCenter.shared.planningSessionCode(from: mockedUrl)
        
        // Then: The sessionCode returned is nil
        XCTAssertNil(sessionCode)
    }

}
