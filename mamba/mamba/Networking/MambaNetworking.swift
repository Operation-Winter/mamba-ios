//
//  MambaNetworking.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

public class MambaNetworking {
    static let shared = MambaNetworking()
    
    private var webSocket: WebSocketHandler?

    private init() {}
    
    public func startPlanningHostSession() -> AnyPublisher<Result<PlanningCommands.HostReceive, NetworkError>, NetworkCloseError> {
        let webSocketHandler = createWebSocketHandler(URLCenter.shared.planningHostWSURL)
        return createWebSocketPublisher(webSocketHandler.subject)
    }
    
    public func send(command: PlanningCommands.HostSend) throws {
        let messageData = try JSONEncoder().encode(command)
        let message = URLSessionWebSocketTask.Message.data(messageData)
        webSocket?.send(message: message)
    }
    
    private func createWebSocketHandler(_ url: URL) -> WebSocketHandler {
        let webSocketHandler = WebSocketHandler(url: url)
        webSocketHandler.start()
        webSocket = webSocketHandler
        return webSocketHandler
    }
    
    private func createWebSocketPublisher<Command>(_ webSocketSubject: PassthroughSubject<URLSessionWebSocketTask.Message, NetworkCloseError>) -> AnyPublisher<Result<Command, NetworkError>, NetworkCloseError> where Command : Codable {
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
    
    private func decodeCommand<Command>(_ data: Data) -> Result<Command, NetworkError> where Command : Codable {
        do {
            //TODO: Use os_log
            let jsonString = String(decoding: data, as: UTF8.self)
            print(jsonString)
            let command = try JSONDecoder().decode(Command.self, from: data)
            return Result<Command, NetworkError>.success(command)
        } catch let error as DecodingError {
            return Result<Command, NetworkError>.failure(NetworkError.parseDecodingError(error))
        } catch {
            return Result<Command, NetworkError>.failure(NetworkError.unknownError(error))
        }
    }
    
    
}
