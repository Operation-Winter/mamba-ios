//
//  CommandNetworking.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/31.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

class CommandNetworking {
    static func createWebSocketPublisher<Command>(_ webSocketSubject: PassthroughSubject<URLSessionWebSocketTask.Message, NetworkCloseError>) -> AnyPublisher<Result<Command, NetworkError>, NetworkCloseError> where Command : Codable {
        return webSocketSubject
            .compactMap { self.parseMessage($0) }
            .map { self.decodeCommand($0) }
            .eraseToAnyPublisher()
    }
    
    static func parseMessage(_ message: URLSessionWebSocketTask.Message) -> Data? {
        switch message {
        case .data(let data): return data
        case .string(let value): return value.data(using: .utf8)
        @unknown default: return nil
        }
    }
    
    static func decodeCommand<Command>(_ data: Data) -> Result<Command, NetworkError> where Command : Codable {
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
