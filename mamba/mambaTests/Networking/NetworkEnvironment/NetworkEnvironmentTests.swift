//
//  NetworkEnvironmentTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class NetworkEnvironmentTests: XCTestCase {

    func testLocalNetworkEnvironmentURLs() {
        //Given: a local network environment
        let networkEnvironment = LocalNetworkEnvironment()
        
        // When: the base URLs are mapped
        let baseURL = networkEnvironment.baseURL
        let socketBaseURL = networkEnvironment.webSocketBaseURL
        
        // Then: the URLs match expected values
        XCTAssertEqual(baseURL.absoluteString, "http://localhost:8080")
        XCTAssertEqual(socketBaseURL.absoluteString, "ws://localhost:8080")
    }
    
    func testDevelopmentNetworkEnvironmentURLs() {
        //Given: a development network environment
        let networkEnvironment = DevelopmentNetworkEnvironment()
        
        // When: the base URLs are mapped
        let baseURL = networkEnvironment.baseURL
        let socketBaseURL = networkEnvironment.webSocketBaseURL
        
        // Then: the URLs match expected values
        XCTAssertEqual(baseURL.absoluteString, "http://mamba.armandkamffer.co.za:83")
        XCTAssertEqual(socketBaseURL.absoluteString, "ws://mamba.armandkamffer.co.za:83")
    }

}
