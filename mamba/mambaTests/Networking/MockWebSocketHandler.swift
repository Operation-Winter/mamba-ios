//
//  MockWebSocketHandler.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine
@testable import Mamba

class MockWebSocketHandler: WebSocketAbstractHandler {
    var subject = PassthroughSubject<URLSessionWebSocketTask.Message, NetworkCloseError>()
    var receivedMessage: URLSessionWebSocketTask.Message?
    var receiveError: Error?
    var pingError: Error?
    var sendError: Error?
    
    required init(url: URL) { }
    
    init() { }
    
    convenience init(url: URL, receivedMessage: URLSessionWebSocketTask.Message? = nil, receiveError: Error? = nil, pingError: Error? = nil, sendError: Error? = nil) {
        self.init(url: url)
        self.receivedMessage = receivedMessage
        self.receiveError = receiveError
        self.pingError = pingError
        self.sendError = sendError
    }
    
    func start() { }
    
    func receiveMessage() {
        if let error = receiveError {
            self.subject.send(completion: .failure(.socketReceiveFailure(error)))
        }
        if let message = receivedMessage {
            self.subject.send(message)
        }
    }
    
    func ping() {
        if let error = pingError {
            self.subject.send(completion: .failure(.socketPingFailure(error)))
        }
    }
    
    func send(message: URLSessionWebSocketTask.Message) {
        if let error = sendError {
            self.subject.send(completion: .failure(.socketSendFailure(error)))
        }
    }
    
    func close() {
        self.subject.send(completion: .finished)
    }
}
