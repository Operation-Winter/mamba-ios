//
//  NetworkCloseErrorTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class NetworkCloseErrorTests: XCTestCase {

    func testSocketReceiveFailureErrorCode() throws {
        // Given: a mock error
        let mockError = NSError(domain: "", code: 0, userInfo: nil)
        
        // When: NetworkCloseError is mapped
        let networkError = NetworkCloseError.socketReceiveFailure(mockError)
        
        // Then: the error code matches expected value
        XCTAssertEqual(networkError.errorCode, "3000")
    }

    func testSocketReceiveFailureErrorDescription() throws {
        // Given: a mock error
        let mockError = NSError(domain: "", code: 0, userInfo: nil)
        
        // When: NetworkCloseError is mapped
        let networkError = NetworkCloseError.socketReceiveFailure(mockError)
        
        // Then: the error description matches expected value
        XCTAssertEqual(networkError.errorDescription, "The operation couldn’t be completed. ( error 0.)")
    }

    func testSocketPingFailureErrorCode() throws {
        // Given: a mock error
        let mockError = NSError(domain: "", code: 0, userInfo: nil)
        
        // When: NetworkCloseError is mapped
        let networkError = NetworkCloseError.socketPingFailure(mockError)
        
        // Then: the error code matches expected value
        XCTAssertEqual(networkError.errorCode, "3001")
    }

    func testSocketPingFailureErrorDescription() throws {
        // Given: a mock error
        let mockError = NSError(domain: "", code: 0, userInfo: nil)
        
        // When: NetworkCloseError is mapped
        let networkError = NetworkCloseError.socketPingFailure(mockError)
        
        // Then: the error description matches expected value
        XCTAssertEqual(networkError.errorDescription, "The operation couldn’t be completed. ( error 0.)")
    }
    
    func testSocketSendFailureErrorCode() throws {
        // Given: a mock error
        let mockError = NSError(domain: "", code: 0, userInfo: nil)
        
        // When: NetworkCloseError is mapped
        let networkError = NetworkCloseError.socketSendFailure(mockError)
        
        // Then: the error code matches expected value
        XCTAssertEqual(networkError.errorCode, "3002")
    }

    func testSocketSendFailureErrorDescription() throws {
        // Given: a mock error
        let mockError = NSError(domain: "", code: 0, userInfo: nil)
        
        // When: NetworkCloseError is mapped
        let networkError = NetworkCloseError.socketSendFailure(mockError)
        
        // Then: the error description matches expected value
        XCTAssertEqual(networkError.errorDescription, "The operation couldn’t be completed. ( error 0.)")
    }

}
