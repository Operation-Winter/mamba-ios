//
//  PlanningSessionNetworkHandlerTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
import MambaNetworking
@testable import Mamba

class PlanningSessionNetworkHandlerTests: XCTestCase {
    
    func testReceiveMessage() {
        // Given: a mock WebSocketHandler and PlanningSessionNetworkHandler
        let mockWebHandler = Mocks.receiveWebHandler
        let networkHandler = PlanningSessionNetworkHandler<PlanningCommands.HostServerReceive, PlanningCommands.HostServerSend>()
        networkHandler.configure(webSocket: mockWebHandler)
        
        var receivedCommand: PlanningCommands.HostServerSend?
        var networkCloseError: NetworkCloseError?
        var receivedError: Error?
        var finished: Bool = false
        
        let expectation = self.expectation(description: "startSession")
        
        // When: a session is started and a message received
        let cancellable = networkHandler.start(webSocketURL: Mocks.url).sink(receiveCompletion: { networkError in
            switch networkError {
            case .finished:
                finished = true
            case .failure(let error):
                networkCloseError = error
            }
            expectation.fulfill()
        }) { result in
            switch result {
            case .success(let command):
                receivedCommand = command
                expectation.fulfill()
            case .failure(let error):
                receivedError = error
                expectation.fulfill()
            }
        }
        mockWebHandler.receiveMessage()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        // Then: receivedCommand is not nil, networkClose error is nil, receivedError is nil, finished is false
        XCTAssertNotNil(receivedCommand)
        XCTAssertNil(networkCloseError)
        XCTAssertNil(receivedError)
        XCTAssertFalse(finished)
        
        cancellable.cancel()
    }
    
    func testReceiveMessageNetworkCloseError() {
        // Given: a mock WebSocketHandler and PlanningSessionNetworkHandler
        let mockWebHandler = Mocks.receiveErrorWebHandler
        let networkHandler = PlanningSessionNetworkHandler<PlanningCommands.HostServerReceive, PlanningCommands.HostServerSend>()
        networkHandler.configure(webSocket: mockWebHandler)
        
        var receivedCommand: PlanningCommands.HostServerSend?
        var networkCloseError: NetworkCloseError?
        var receivedError: Error?
        var finished: Bool = false
        
        let expectation = self.expectation(description: "startSession")
        
        // When: a session is started and a message received
        let cancellable = networkHandler.start(webSocketURL: Mocks.url).sink(receiveCompletion: { networkError in
            switch networkError {
            case .finished:
                finished = true
            case .failure(let error):
                networkCloseError = error
            }
            expectation.fulfill()
        }) { result in
            switch result {
            case .success(let command):
                receivedCommand = command
                expectation.fulfill()
            case .failure(let error):
                receivedError = error
                expectation.fulfill()
            }
        }
        mockWebHandler.receiveMessage()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        // Then: receivedCommand is nil, networkClose error is not nil, receivedError is nil, finished is false
        XCTAssertNil(receivedCommand)
        XCTAssertNotNil(networkCloseError)
        XCTAssertNil(receivedError)
        XCTAssertFalse(finished)
        
        cancellable.cancel()
    }
    
    func testDecodingError() {
        // Given: a mock WebSocketHandler and PlanningSessionNetworkHandler
        let mockWebHandler = Mocks.decodingErrorWebHandler
        let networkHandler = PlanningSessionNetworkHandler<PlanningCommands.HostServerReceive, PlanningCommands.HostServerSend>()
        networkHandler.configure(webSocket: mockWebHandler)
        
        var receivedCommand: PlanningCommands.HostServerSend?
        var networkCloseError: NetworkCloseError?
        var receivedError: Error?
        var finished: Bool = false
        
        let expectation = self.expectation(description: "startSession")
        
        // When: a session is started and a message is received
        let cancellable = networkHandler.start(webSocketURL: Mocks.url).sink(receiveCompletion: { networkError in
            switch networkError {
            case .finished:
                finished = true
            case .failure(let error):
                networkCloseError = error
            }
            expectation.fulfill()
        }) { result in
            switch result {
            case .success(let command):
                receivedCommand = command
                expectation.fulfill()
            case .failure(let error):
                receivedError = error
                expectation.fulfill()
            }
        }
        mockWebHandler.receiveMessage()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        // Then: receivedCommand is nil, networkClose error is nil, receivedError is not nil, finished is false
        XCTAssertNil(receivedCommand)
        XCTAssertNil(networkCloseError)
        XCTAssertNotNil(receivedError)
        XCTAssertFalse(finished)
        
        cancellable.cancel()
    }
    
    func testFinishedState() {
        // Given: a mock WebSocketHandler and PlanningSessionNetworkHandler
        let mockWebHandler = Mocks.receiveWebHandler
        let networkHandler = PlanningSessionNetworkHandler<PlanningCommands.HostServerReceive, PlanningCommands.HostServerSend>()
        networkHandler.configure(webSocket: mockWebHandler)
        
        var receivedCommand: PlanningCommands.HostServerSend?
        var networkCloseError: NetworkCloseError?
        var receivedError: Error?
        var finished: Bool = false
        
        let expectation = self.expectation(description: "startSession")
        
        // When: a session is started and a webSocket is closed
        let cancellable = networkHandler.start(webSocketURL: Mocks.url).sink(receiveCompletion: { networkError in
            switch networkError {
            case .finished:
                finished = true
            case .failure(let error):
                networkCloseError = error
            }
            expectation.fulfill()
        }) { result in
            switch result {
            case .success(let command):
                receivedCommand = command
                expectation.fulfill()
            case .failure(let error):
                receivedError = error
                expectation.fulfill()
            }
        }
        mockWebHandler.close()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        // Then: receivedCommand is nil, networkClose error is nil, receivedError is nil, finished is true
        XCTAssertNil(receivedCommand)
        XCTAssertNil(networkCloseError)
        XCTAssertNil(receivedError)
        XCTAssertTrue(finished)
        
        cancellable.cancel()
    }

}

fileprivate class Mocks {
    static var url: URL {
        return URL(string: "ws://localhost")!
    }
    
    static var receiveWebHandler: MockWebSocketHandler {
        let message = URLSessionWebSocketTask.Message.data(startSessionCommandData)
        return MockWebSocketHandler(url: url, receivedMessage: message)
    }
    
    static var receiveErrorWebHandler: MockWebSocketHandler {
        let error = NSError(domain: "", code: 0, userInfo: nil)
        return MockWebSocketHandler(url: url, receiveError: error)
    }
    
    static var decodingErrorWebHandler: MockWebSocketHandler {
        let message = URLSessionWebSocketTask.Message.data(invalidCommandData)
        return MockWebSocketHandler(url: url, receivedMessage: message)
    }
    
    static var startSessionCommandData: Data {
        return "{ \"type\": \"INVALID_COMMAND\", \"message\": {\"code\":\"0000\",\"description\":\"No session code has been specified\"} }".data(using: .utf8)!
    }
    
    static var invalidCommandData: Data {
        return "{ \"type\": \"INVALID_COMMAND\" }".data(using: .utf8)!
    }
}
