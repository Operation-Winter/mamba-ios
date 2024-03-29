//
//  PlanningSessionNetworkHandler.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/31.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

public class PlanningSessionNetworkHandler<Send: Encodable, Receive: Decodable> {
    private var webSocket: WebSocketAbstractHandler?
    private var pingWebsocketSubject = PassthroughSubject<Void, Never>()
    private var cancellable: AnyCancellable?
    
    public var connectionStatusPublisher: AnyPublisher<Bool, Never>? {
        webSocket?.connectionStatus.eraseToAnyPublisher()
    }
    
    public func start(webSocketURL: URL) -> AnyPublisher<Result<Receive, NetworkError>, NetworkCloseError> {
        var webSocket: WebSocketAbstractHandler
        if let socketHandler = self.webSocket {
            webSocket = socketHandler
        } else {
            webSocket = createWebSocketHandler(url: webSocketURL)
        }
        return createWebSocketPublisher(webSocket.subject)
    }
    
    public func send(command: Send) throws {
        let messageData = try JSONEncoder().encode(command)
        Log.networking.logger.debug("Command data sent: \(String(describing: command))")
        webSocket?.send(message: messageData)
        pingWebsocketSubject.send()
    }
    
    public func configure(webSocket: WebSocketAbstractHandler) {
        self.webSocket = webSocket
    }
    
    public func close() {
        webSocket?.close()
    }
    
    private func createWebSocketHandler(url: URL) -> WebSocketAbstractHandler {
        let webSocketHandler = WebSocketHandler(url: url)
        webSocketHandler.start()
        webSocket = webSocketHandler
        
        cancellable = pingWebsocketSubject
            .debounce(for: .seconds(10), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.pingWebSocket()
            })
        
        return webSocketHandler
    }
    
    private func pingWebSocket() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.webSocket?.ping()
            self?.pingWebsocketSubject.send()
        }
    }
    
    private func createWebSocketPublisher<Command: Decodable>(_ webSocketSubject: PassthroughSubject<WebSocketMessage, NetworkCloseError>) -> AnyPublisher<Result<Command, NetworkError>, NetworkCloseError> {
        return webSocketSubject
            .receive(on: DispatchQueue.global(qos: .background))
            .compactMap { self.parseMessage($0) }
            .map { self.decodeCommand($0) }
            .eraseToAnyPublisher()
    }
    
    private func parseMessage(_ message: WebSocketMessage) -> Data? {
        switch message {
        case .data(let data): return data
        case .text(let value): return value.data(using: .utf8)
        }
    }
    
    private func decodeCommand<Command: Decodable>(_ data: Data) -> Result<Command, NetworkError> {
        do {
            let jsonString = String(decoding: data, as: UTF8.self)
            Log.networking.logger.debug("Command received: \(jsonString)")
            let command = try JSONDecoder().decode(Command.self, from: data)
            return Result<Command, NetworkError>.success(command)
        } catch let error as DecodingError {
            Log.networking.logger.error("ParseDecodingError: \(String(describing: PlanningSessionNetworkHandler.self)) \(error.localizedDescription) \(String(describing: Send.self)) \(String(describing: Receive.self))")
            return Result<Command, NetworkError>.failure(NetworkError.parseDecodingError(error))
        } catch {
            Log.networking.logger.error("UnknownError: \(String(describing: PlanningSessionNetworkHandler.self)) \(error.localizedDescription) \(String(describing: Send.self)) \(String(describing: Receive.self))")
            return Result<Command, NetworkError>.failure(NetworkError.unknownError(error))
        }
    }
}
