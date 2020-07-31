//
//  MambaHostSessionNetworkHandler.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/31.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

public class PlanningHostSessionNetworkHandler {
    private var webSocket: WebSocketHandler?
    
    /// Starts a session with the Host Planning endpoint and sets up a pipeline of received commands
    /// - Returns: A Publisher that publishes the commands received over the WebSocket
    public func startSession() -> AnyPublisher<Result<PlanningCommands.JoinReceive, NetworkError>, NetworkCloseError> {
        let webSocketHandler = createWebSocketHandler(URLCenter.shared.planningJoinWSURL)
        return CommandNetworking.createWebSocketPublisher(webSocketHandler.subject)
    }
    
    public func send(command: PlanningCommands.JoinSend) throws {
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
}
