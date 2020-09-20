//
//  WebSocketHandler.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

public protocol WebSocketAbstractHandler {
    var subject: PassthroughSubject<URLSessionWebSocketTask.Message, NetworkCloseError> { get }
    
    init(url: URL)
    func start()
    func receiveMessage()
    func ping()
    func send(message: URLSessionWebSocketTask.Message)
    func close()
}

class WebSocketHandler: WebSocketAbstractHandler {
    public private(set) var subject = PassthroughSubject<URLSessionWebSocketTask.Message, NetworkCloseError>()
    private var webSocketTask: URLSessionWebSocketTask
    
    required public init(url: URL) {
        let urlSession = URLSession(configuration: .ephemeral)
        self.webSocketTask = urlSession.webSocketTask(with: url)
        Log.networking.logger.info("URLSession webSocketTask opened to \(url.absoluteString)")
    }
    
    public func start() {
        Log.networking.logger.info("Start WebSocketTask Session")
        webSocketTask.resume()
        receiveMessage()
    }
    
    public func receiveMessage() {
        webSocketTask.receive { [weak self] result in
            switch result {
            case .failure(let error):
                self?.subject.send(completion: .failure(.socketReceiveFailure(error)))
                Log.networking.logger.error("SocketReceiveFailure: \(String(describing: WebSocketHandler.self)) \(error.localizedDescription)")
            case .success(let message):
                self?.subject.send(message)
                Log.networking.logger.info("WebSocket task received message")
                self?.receiveMessage()
            }
        }
    }
    
    public func ping() {
        Log.networking.logger.info("Ping WebSocketTask")
        webSocketTask.sendPing { [weak self] error in
            guard let error = error else { return }
            self?.subject.send(completion: .failure(.socketPingFailure(error)))
            Log.networking.logger.error("SocketPingFailure: \(String(describing: WebSocketHandler.self)) \(error.localizedDescription)")
        }
    }
    
    public func send(message: URLSessionWebSocketTask.Message) {
        Log.networking.logger.info("Send WebSocketTask Message")
        webSocketTask.send(message) { [weak self] error in
            guard let error = error else { return }
            self?.subject.send(completion: .failure(.socketSendFailure(error)))
            Log.networking.logger.error("SocketSendFailure: \(String(describing: WebSocketHandler.self)) \(error.localizedDescription)")
        }
    }
    
    public func close() {
        webSocketTask.cancel(with: .normalClosure, reason: nil)
        self.subject.send(completion: .finished)
        Log.networking.logger.error("Close webSocketTask")
    }
}
