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
    var subject = PassthroughSubject<WebSocketMessage, NetworkCloseError>()
    var connectionStatus = CurrentValueSubject<Bool, Never>(false)
    var receivedMessage: WebSocketMessage?
    var receiveError: Error?
    
    required init(url: URL) { }
    
    init() { }
    
    convenience init(url: URL, receivedMessage: WebSocketMessage? = nil, receiveError: Error? = nil) {
        self.init(url: url)
        self.receivedMessage = receivedMessage
        self.receiveError = receiveError
    }
    
    func start() { }
    
    func receiveMessage() {
        if let error = receiveError {
            self.subject.send(completion: .failure(.failure(error)))
        }
        if let message = receivedMessage {
            self.subject.send(message)
        }
    }
    
    func ping() {
    }
    
    func send(message: Data) {
    }
    
    func close() {
        self.subject.send(completion: .finished)
    }
}
