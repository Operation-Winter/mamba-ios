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
    
    public func startPlanningHostSession() -> AnyPublisher<PlanningCommands.HostReceive, Error> {
        let planningHostUrl = URLCenter.shared.planningHostWSURL()
        let webSocketHandler = WebSocketHandler(url: planningHostUrl)
        webSocketHandler.start()
        webSocket = webSocketHandler
        
        return webSocketHandler.subject
            .compactMap {
                switch $0 {
                case .data(let data): return data
                case .string(let value):
                    guard let data = value.data(using: .utf8) else { return nil }
                    return data
                @unknown default:
                    return nil
                }
            }
            .decode(type: PlanningCommands.HostReceive.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    public func send(command: PlanningCommands.HostSend) throws {
        let messageData = try JSONEncoder().encode(command)
        let message = URLSessionWebSocketTask.Message.data(messageData)
        webSocket?.send(message: message)
    }
}
