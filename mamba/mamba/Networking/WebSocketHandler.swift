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
    var connectionStatus: CurrentValueSubject<Bool, Never> { get }
    
    init(url: URL)
    func start()
    func receiveMessage()
    func ping()
    func send(message: URLSessionWebSocketTask.Message)
    func close()
}

class WebSocketHandler: NSObject, WebSocketAbstractHandler {
    public private(set) var subject = PassthroughSubject<URLSessionWebSocketTask.Message, NetworkCloseError>()
    public private(set) var connectionStatus = CurrentValueSubject<Bool, Never>(false)
    private var webSocketTask: URLSessionWebSocketTask?
    private var url: URL
    
    required public init(url: URL) {
        self.url = url
    }
    
    public func start() {
        let urlSession = URLSession(configuration: .ephemeral, delegate: self, delegateQueue: OperationQueue.main)
        webSocketTask = urlSession.webSocketTask(with: url)
        Log.networking.logger.info("URLSession webSocketTask opened to \(self.url.absoluteString)")
        
        webSocketTask?.resume()
        receiveMessage()
    }
    
    public func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
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
        webSocketTask?.sendPing { [weak self] error in
            guard let error = error else { return }
            self?.subject.send(completion: .failure(.socketPingFailure(error)))
            Log.networking.logger.error("SocketPingFailure: \(String(describing: WebSocketHandler.self)) \(error.localizedDescription)")
        }
    }
    
    public func send(message: URLSessionWebSocketTask.Message) {
        Log.networking.logger.info("Send WebSocketTask Message")
        webSocketTask?.send(message) { [weak self] error in
            guard let error = error else { return }
            self?.subject.send(completion: .failure(.socketSendFailure(error)))
            Log.networking.logger.error("SocketSendFailure: \(String(describing: WebSocketHandler.self)) \(error.localizedDescription)")
        }
    }
    
    public func close() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
        subject.send(completion: .finished)
        Log.networking.logger.error("Close webSocketTask")
    }
}

extension WebSocketHandler: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        connectionStatus.send(true)
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        connectionStatus.send(false)
    }
}
