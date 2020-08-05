//
//  WebSocketHandler.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

class WebSocketHandler {
    public var subject = PassthroughSubject<URLSessionWebSocketTask.Message, NetworkCloseError>()
    private var webSocketTask: URLSessionWebSocketTask
    
    init(url: URL) {
        let urlSession = URLSession(configuration: .ephemeral)
        self.webSocketTask = urlSession.webSocketTask(with: url)
    }
    
    public func start() {
        webSocketTask.resume()
        receiveMessage()
    }
    
    public func receiveMessage() {
        webSocketTask.receive { result in
            switch result {
            case .failure(let error):
                self.subject.send(completion: .failure(.socketReceiveFailure(error)))
            case .success(let message):
                self.subject.send(message)
                self.receiveMessage()
            }
        }
    }
    
    public func ping() {
        webSocketTask.sendPing { error in
            guard let error = error else { return }
            self.subject.send(completion: .failure(.socketPingFailure(error)))
        }
    }
    
    public func send(message: URLSessionWebSocketTask.Message) {
        webSocketTask.send(message) { error in
            guard let error = error else { return }
            self.subject.send(completion: .failure(.socketSendFailure(error)))
        }
    }
    
    public func close() {
        webSocketTask.cancel(with: .normalClosure, reason: nil)
        self.subject.send(completion: .finished)
    }
}
