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
    private var webSocket: WebSocketHandler?
    
    public func startSession(webSocketURL: URL) -> AnyPublisher<Result<Receive, NetworkError>, NetworkCloseError> {
        let webSocketHandler = createWebSocketHandler(url: webSocketURL)
        return createWebSocketPublisher(webSocketHandler.subject)
    }
    
    public func send(command: Send) throws {
        let messageData = try JSONEncoder().encode(command)
        Log.log(level: .debug, category: .networking, message: "Command data sent: %{private}@", args: String(describing: command))
        let message = URLSessionWebSocketTask.Message.data(messageData)
        webSocket?.send(message: message)
    }
    
    private func createWebSocketHandler(url: URL) -> WebSocketHandler {
        let webSocketHandler = WebSocketHandler(url: url)
        webSocketHandler.start()
        webSocket = webSocketHandler
        pingWebSocket()
        return webSocketHandler
    }
    
    private func pingWebSocket() {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 10) { [weak self] in
            self?.webSocket?.ping()
        }
    }
    
    private func createWebSocketPublisher<Command: Decodable>(_ webSocketSubject: PassthroughSubject<URLSessionWebSocketTask.Message, NetworkCloseError>) -> AnyPublisher<Result<Command, NetworkError>, NetworkCloseError> {
        return webSocketSubject
            .compactMap { self.parseMessage($0) }
            .map { self.decodeCommand($0) }
            .eraseToAnyPublisher()
    }
    
    private func parseMessage(_ message: URLSessionWebSocketTask.Message) -> Data? {
        switch message {
        case .data(let data): return data
        case .string(let value): return value.data(using: .utf8)
        @unknown default: return nil
        }
    }
    
    private func decodeCommand<Command: Decodable>(_ data: Data) -> Result<Command, NetworkError> {
        do {
            let jsonString = String(decoding: data, as: UTF8.self)
            Log.log(level: .debug, category: .networking, message: "Command received: %{private}@", args: jsonString)
            let command = try JSONDecoder().decode(Command.self, from: data)
            return Result<Command, NetworkError>.success(command)
        } catch let error as DecodingError {
            Log.log(level: .error, category: .networking, message: "%{private}@: ParseDecodingError: %{private}@ %@ %@", args: String(describing: PlanningSessionNetworkHandler.self), error.localizedDescription, String(describing: Send.self), String(describing: Receive.self))
            return Result<Command, NetworkError>.failure(NetworkError.parseDecodingError(error))
        } catch {
            Log.log(level: .error, category: .networking, message: "%{private}@: UnknownError: %{private}@ %@ %@", args: String(describing: PlanningSessionNetworkHandler.self), error.localizedDescription, String(describing: Send.self), String(describing: Receive.self))
            return Result<Command, NetworkError>.failure(NetworkError.unknownError(error))
        }
    }
}
