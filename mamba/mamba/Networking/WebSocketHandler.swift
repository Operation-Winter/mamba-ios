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
        Log.log(level: .info, category: .networking, message: "URLSession webSocketTask opened to %{private}@", args: url.absoluteString)
    }
    
    public func start() {
        Log.log(level: .info, category: .networking, message: "Start WebSocketTask Session")
        webSocketTask.resume()
        receiveMessage()
    }
    
    public func receiveMessage() {
        webSocketTask.receive { [weak self] result in
            switch result {
            case .failure(let error):
                self?.subject.send(completion: .failure(.socketReceiveFailure(error)))
                Log.log(level: .error, category: .networking, message: "SocketReceiveFailure: %@", args: "\(String(describing: WebSocketHandler.self)) \(error.localizedDescription)")
            case .success(let message):
                self?.subject.send(message)
                Log.log(level: .info, category: .networking, message: "WebSocket task received message")
                self?.receiveMessage()
            }
        }
    }
    
    public func ping() {
        Log.log(level: .info, category: .networking, message: "Ping WebSocketTask")
        webSocketTask.sendPing { [weak self] error in
            guard let error = error else { return }
            self?.subject.send(completion: .failure(.socketPingFailure(error)))
            Log.log(level: .error, category: .networking, message: "SocketPingFailure: %@", args: "\(String(describing: WebSocketHandler.self)) \(error.localizedDescription)")
        }
    }
    
    public func send(message: URLSessionWebSocketTask.Message) {
        Log.log(level: .info, category: .networking, message: "Send WebSocketTask Message")
        webSocketTask.send(message) { [weak self] error in
            guard let error = error else { return }
            self?.subject.send(completion: .failure(.socketSendFailure(error)))
            Log.log(level: .error, category: .networking, message: "SocketSendFailure: %@", args: "\(String(describing: WebSocketHandler.self)) \(error.localizedDescription)")
        }
    }
    
    public func close() {
        webSocketTask.cancel(with: .normalClosure, reason: nil)
        self.subject.send(completion: .finished)
        Log.log(level: .error, category: .networking, message: "%{private}@: Close webSocketTask", args: String(describing: WebSocketHandler.self))
    }
}
