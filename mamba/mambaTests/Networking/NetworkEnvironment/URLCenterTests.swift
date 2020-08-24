//
//  URLCenterTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class URLCenterTests: XCTestCase {

    func testMakeEnvironmentLocalEnvironmentType() {
        // Given: Local network environment type
        let mockEnvironmentType = NetworkEnvironmentType.local
        
        // When: environment is mapped
        let environment = URLCenter.shared.makeNetworkEnvironment(mockEnvironmentType)
        
        // Then: Environment is of type LocalNetworkEnvironment
        XCTAssert(environment is LocalNetworkEnvironment)
    }
    
    func testMakeEnvironmentDevelopmentEnvironmentType() {
        // Given: Development network environment type
        let mockEnvironmentType = NetworkEnvironmentType.development
        
        // When: environment is mapped
        let environment = URLCenter.shared.makeNetworkEnvironment(mockEnvironmentType)
        
        // Then: Environment is of type LocalNetworkEnvironment
        XCTAssert(environment is DevelopmentNetworkEnvironment)
    }
    
    func testMakeEnvironmentProductionEnvironmentType() {
        // Given: Production network environment type
        let mockEnvironmentType = NetworkEnvironmentType.production
        
        // When: environment is mapped
        let environment = URLCenter.shared.makeNetworkEnvironment(mockEnvironmentType)
        
        // Then: Environment is of type LocalNetworkEnvironment
        XCTAssert(environment is DevelopmentNetworkEnvironment)
    }
    
    func testBaseUrl() {
        // Then: Base URL matches expected value
        XCTAssertEqual(URLCenter.shared.baseURL.absoluteString, "http://localhost:8080")
    }
    
    func testWebSocketBaseUrl() {
        // Then: Base WebSocket URL matches expected value
        XCTAssertEqual(URLCenter.shared.webSocketBaseURL.absoluteString, "ws://localhost:8080")
    }

}
