//
//  NetworkErrorTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class NetworkErrorTests: XCTestCase {

    func testDecodingTypeMismatchErrorCode() throws {
        // Given: a mock error description
        let mockErrorDescription = "Unit tests error"
        
        // When: NetworkError is mapped
        let error = NetworkError.decodingTypeMistmatch(mockErrorDescription)
        
        // Then: the error code matches expected value
        XCTAssertEqual(error.errorCode, "3100")
    }

    func testDecodingTypeMismatchErrorDescription() throws {
        // Given: a mock error description
        let mockErrorDescription = "Unit tests error"
        
        // When: NetworkError is mapped
        let error = NetworkError.decodingTypeMistmatch(mockErrorDescription)
        
        // Then: the error description matches expected value
        XCTAssertEqual(error.errorDescription, mockErrorDescription)
    }
    
    func testDecodingValueNotFoundErrorCode() throws {
        // Given: a mock error description
        let mockErrorDescription = "Unit tests error"
        
        // When: NetworkError is mapped
        let error = NetworkError.decodingValueNotFound(mockErrorDescription)
        
        // Then: the error code matches expected value
        XCTAssertEqual(error.errorCode, "3101")
    }

    func testDecodingValueNotFoundErrorDescription() throws {
        // Given: a mock error description
        let mockErrorDescription = "Unit tests error"
        
        // When: NetworkError is mapped
        let error = NetworkError.decodingValueNotFound(mockErrorDescription)
        
        // Then: the error description matches expected value
        XCTAssertEqual(error.errorDescription, mockErrorDescription)
    }

    
    func testDecodingKeyNotFoundErrorCode() throws {
        // Given: a mock error description
        let mockErrorDescription = "Unit tests error"
        
        // When: NetworkError is mapped
        let error = NetworkError.decodingKeyNotFound(mockErrorDescription)
        
        // Then: the error code matches expected value
        XCTAssertEqual(error.errorCode, "3102")
    }

    func testDecodingKeyNotFoundErrorDescription() throws {
        // Given: a mock error description
        let mockErrorDescription = "Unit tests error"
        
        // When: NetworkError is mapped
        let error = NetworkError.decodingKeyNotFound(mockErrorDescription)
        
        // Then: the error description matches expected value
        XCTAssertEqual(error.errorDescription, mockErrorDescription)
    }
    
    func testDecodingDataCorruptedErrorCode() throws {
        // Given: a mock error description
        let mockErrorDescription = "Unit tests error"
        
        // When: NetworkError is mapped
        let error = NetworkError.decodingDataCorrupted(mockErrorDescription)
        
        // Then: the error code matches expected value
        XCTAssertEqual(error.errorCode, "3103")
    }

    func testDecodingDataCorruptedErrorDescription() throws {
        // Given: a mock error description
        let mockErrorDescription = "Unit tests error"
        
        // When: NetworkError is mapped
        let error = NetworkError.decodingDataCorrupted(mockErrorDescription)
        
        // Then: the error description matches expected value
        XCTAssertEqual(error.errorDescription, mockErrorDescription)
    }
    
    func testUnknownDecodingErrorCode() throws {
        // Given: a mock decoding error
        let mockDecodingError = DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Test error description"))
        
        // When: NetworkError is mapped
        let error = NetworkError.unknownDecodingError(mockDecodingError)
        
        // Then: the error code matches expected value
        XCTAssertEqual(error.errorCode, "3104")
    }

    func testUnknownDecodingErrorDescription() throws {
        // Given: a mock decoding error
        let mockDecodingError = DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Test error description"))
        
        // When: NetworkError is mapped
        let error = NetworkError.unknownDecodingError(mockDecodingError)
        
        // Then: the error description matches expected value
        XCTAssertEqual(error.errorDescription, mockDecodingError.localizedDescription)
    }
    
    func testUnknownErrorCode() throws {
        // Given: a mock error
        let mockError = NSError(domain: "", code: 0, userInfo: nil)
        
        // When: NetworkError is mapped
        let error = NetworkError.unknownError(mockError)
        
        // Then: the error code matches expected value
        XCTAssertEqual(error.errorCode, "3105")
    }

    func testUnknownErrorDescription() throws {
        // Given: a mock error
        let mockError = NSError(domain: "", code: 0, userInfo: nil)
        
        // When: NetworkError is mapped
        let error = NetworkError.unknownError(mockError)
        
        // Then: the error description matches expected value
        XCTAssertEqual(error.errorDescription, "The operation couldn’t be completed. ( error 0.)")
    }
    
}
