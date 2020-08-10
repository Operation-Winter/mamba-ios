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
        let networkError = NetworkError.decodingTypeMistmatch(mockErrorDescription)
        
        // Then: the error code matches expected value
        XCTAssertEqual(networkError.errorCode, "3100")
    }

    func testDecodingTypeMismatchErrorDescription() throws {
        // Given: a mock error description
        let mockErrorDescription = "Unit tests error"
        
        // When: NetworkError is mapped
        let networkError = NetworkError.decodingTypeMistmatch(mockErrorDescription)
        
        // Then: the error description matches expected value
        XCTAssertEqual(networkError.errorDescription, mockErrorDescription)
    }
    
    func testDecodingTypeMismatchErrorParse() throws {
        // Given: a mock decoding error
        let mockDecodingError = DecodingError.typeMismatch(Any.self, .init(codingPath: [], debugDescription: "Test"))
        
        // When: NetworkError is mapped
        let networkError = NetworkError.parseDecodingError(mockDecodingError)
        
        // Then: the networkError matches expected value
        if case NetworkError.decodingTypeMistmatch(_) = networkError { } else {
            XCTFail("decodingTypeMistmatch was expected")
        }
    }
    
    func testDecodingValueNotFoundErrorCode() throws {
        // Given: a mock error description
        let mockErrorDescription = "Unit tests error"
        
        // When: NetworkError is mapped
        let networkError = NetworkError.decodingValueNotFound(mockErrorDescription)
        
        // Then: the error code matches expected value
        XCTAssertEqual(networkError.errorCode, "3101")
    }

    func testDecodingValueNotFoundErrorDescription() throws {
        // Given: a mock error description
        let mockErrorDescription = "Unit tests error"
        
        // When: NetworkError is mapped
        let networkError = NetworkError.decodingValueNotFound(mockErrorDescription)
        
        // Then: the error description matches expected value
        XCTAssertEqual(networkError.errorDescription, mockErrorDescription)
    }
    
    func testDecodingValueNotFoundErrorParse() throws {
        // Given: a mock decoding error
        let mockDecodingError = DecodingError.valueNotFound(Any.self, .init(codingPath: [], debugDescription: "Test"))
        
        // When: NetworkError is mapped
        let networkError = NetworkError.parseDecodingError(mockDecodingError)
        
        // Then: the networkError matches expected value
        if case NetworkError.decodingValueNotFound(_) = networkError { } else {
            XCTFail("decodingValueNotFound was expected")
        }
    }
    
    func testDecodingKeyNotFoundErrorCode() throws {
        // Given: a mock error description
        let mockErrorDescription = "Unit tests error"
        
        // When: NetworkError is mapped
        let networkError = NetworkError.decodingKeyNotFound(mockErrorDescription)
        
        // Then: the error code matches expected value
        XCTAssertEqual(networkError.errorCode, "3102")
    }

    func testDecodingKeyNotFoundErrorDescription() throws {
        // Given: a mock error description
        let mockErrorDescription = "Unit tests error"
        
        // When: NetworkError is mapped
        let networkError = NetworkError.decodingKeyNotFound(mockErrorDescription)
        
        // Then: the error description matches expected value
        XCTAssertEqual(networkError.errorDescription, mockErrorDescription)
    }
    
    func testDecodingKeyNotFoundErrorParse() throws {
        // Given: a mock decoding error and codingKey
        enum CodingKeys: CodingKey {
            case test
        }
        let mockDecodingError = DecodingError.keyNotFound(CodingKeys.test, .init(codingPath: [], debugDescription: "Test"))
        
        // When: NetworkError is mapped
        let networkError = NetworkError.parseDecodingError(mockDecodingError)
        
        // Then: the networkError matches expected value
        if case NetworkError.decodingKeyNotFound(_) = networkError { } else {
            XCTFail("decodingKeyNotFound was expected")
        }
    }
    
    func testDecodingDataCorruptedErrorCode() throws {
        // Given: a mock error description
        let mockErrorDescription = "Unit tests error"
        
        // When: NetworkError is mapped
        let networkError = NetworkError.decodingDataCorrupted(mockErrorDescription)
        
        // Then: the error code matches expected value
        XCTAssertEqual(networkError.errorCode, "3103")
    }
    
    func testDecodingDataCorruptedErrorDescription() throws {
        // Given: a mock error description
        let mockErrorDescription = "Unit tests error"
        
        // When: NetworkError is mapped
        let networkError = NetworkError.decodingDataCorrupted(mockErrorDescription)
        
        // Then: the error description matches expected value
        XCTAssertEqual(networkError.errorDescription, mockErrorDescription)
    }
    
    func testDecodingDataCorruptedErrorParse() throws {
        // Given: a mock decoding error
        let mockDecodingError = DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Test"))
        
        // When: NetworkError is mapped
        let networkError = NetworkError.parseDecodingError(mockDecodingError)
        
        // Then: the networkError matches expected value
        if case NetworkError.decodingDataCorrupted(_) = networkError { } else {
            XCTFail("decodingDataCorrupted was expected")
        }
    }
    
    func testUnknownDecodingErrorCode() throws {
        // Given: a mock decoding error
        let mockDecodingError = DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Test error description"))
        
        // When: NetworkError is mapped
        let networkError = NetworkError.unknownDecodingError(mockDecodingError)
        
        // Then: the error code matches expected value
        XCTAssertEqual(networkError.errorCode, "3104")
    }

    func testUnknownDecodingErrorDescription() throws {
        // Given: a mock decoding error
        let mockDecodingError = DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Test error description"))
        
        // When: NetworkError is mapped
        let networkError = NetworkError.unknownDecodingError(mockDecodingError)
        
        // Then: the error description matches expected value
        XCTAssertEqual(networkError.errorDescription, mockDecodingError.localizedDescription)
    }
    
    func testUnknownErrorCode() throws {
        // Given: a mock error
        let mockError = NSError(domain: "", code: 0, userInfo: nil)
        
        // When: NetworkError is mapped
        let networkError = NetworkError.unknownError(mockError)
        
        // Then: the error code matches expected value
        XCTAssertEqual(networkError.errorCode, "3105")
    }

    func testUnknownErrorDescription() throws {
        // Given: a mock error
        let mockError = NSError(domain: "", code: 0, userInfo: nil)
        
        // When: NetworkError is mapped
        let networkError = NetworkError.unknownError(mockError)
        
        // Then: the error description matches expected value
        XCTAssertEqual(networkError.errorDescription, "The operation couldn’t be completed. ( error 0.)")
    }
    
}
