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
    
    var webSocket: WebSocketHandler?
    
    private init() {}
    
    public func startPlanningHostSession(url: URL) -> AnyPublisher<PlanningHostCommand, Error> {
        let webSocketHandler = WebSocketHandler(url: url)
        webSocketHandler.startSession()
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
            .decode(type: PlanningHostCommand.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
