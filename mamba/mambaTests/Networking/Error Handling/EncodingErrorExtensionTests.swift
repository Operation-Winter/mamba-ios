//
//  EncodingErrorExtensionTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class EncodingErrorExtensionTests: XCTestCase {

    func testInvalidValueErrorCode() {
        // Given: a mock error context
        let mockContext = EncodingError.Context(codingPath: [], debugDescription: "Test")
        
        // When: EncodingError is mapped
        let encodingError = EncodingError.invalidValue("Test", mockContext)
        
        // Then: the error code matches expected value
        XCTAssertEqual(encodingError.errorCode, "3200")
    }

    func testInvalidValueErrorDescription() {
        // Given: a mock error context
        let mockContext = EncodingError.Context(codingPath: [], debugDescription: "Test")
        
        // When: EncodingError is mapped
        let encodingError = EncodingError.invalidValue("Test", mockContext)
        
        // Then: the error description matches expected value
        XCTAssertEqual(encodingError.errorCustomDescription, NSLocalizedString("NETWORKING_ERROR_ENCODING_ERROR_INVALID_VALUE_DESCRIPTION", comment: "Localized error description"))
    }
    
}
