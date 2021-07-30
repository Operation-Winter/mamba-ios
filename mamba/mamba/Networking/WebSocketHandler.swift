//
//  WebSocketHandler.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine
import Starscream

public enum WebSocketMessage {
    case text(String)
    case data(Data)
}

public protocol WebSocketAbstractHandler {
    var subject: PassthroughSubject<WebSocketMessage, NetworkCloseError> { get }
    var connectionStatus: CurrentValueSubject<Bool, Never> { get }
    
    init(url: URL)
    func start()
    func ping()
    func send(message: Data)
    func close()
}

class WebSocketHandler: WebSocketAbstractHandler {
    public private(set) var subject = PassthroughSubject<WebSocketMessage, NetworkCloseError>()
    public private(set) var connectionStatus = CurrentValueSubject<Bool, Never>(false)
    private var webSocket: WebSocket?
    private var url: URL
    
    required public init(url: URL) {
        self.url = url
    }
    
    public func start() {
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        webSocket = WebSocket(request: request)
        Log.networking.logger.info("WebSocket opened to \(self.url.absoluteString)")
        
        receiveMessage()
        webSocket?.connect()
    }
    
    public func receiveMessage() {
        webSocket?.onEvent = { [weak self] event in
            switch event {
            case .connected:
                self?.connectionStatus.send(true)
            case .disconnected:
                self?.connectionStatus.send(false)
            case .text(let message):
                self?.subject.send(.text(message))
                Log.networking.logger.info("WebSocket task received message")
            case .binary(let message):
                self?.subject.send(.data(message))
                Log.networking.logger.info("WebSocket task received message")
            case .pong(_):
                break
            case .ping(_):
                break
            case .error(let error):
                self?.subject.send(completion: .failure(.failure(error)))
                Log.networking.logger.error("SocketReceiveFailure: \(String(describing: WebSocketHandler.self)) \(error?.localizedDescription ?? "")")
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                self?.subject.send(completion: .finished)
                Log.networking.logger.info("WebSocket cancelled")
            }
        }
    }
    
    public func ping() {
        Log.networking.logger.info("Ping WebSocketTask")
        webSocket?.write(ping: Data())
    }
    
    public func send(message: Data) {
        Log.networking.logger.info("Send WebSocketTask Message")
        webSocket?.write(data: message)
    }
    
    public func close() {
        webSocket?.disconnect()
        Log.networking.logger.info("Close webSocketTask")
    }
}
