//
//  MambaNetworking.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public class MambaNetworking {
    static let shared = MambaNetworking()
    
    var webSocketTask: URLSessionWebSocketTask?
    
    private init() {}
    
    public func connectToWebSocket(url: URL, successHandler: @escaping (URLSessionWebSocketTask.Message) -> (), errorHandler: @escaping (Error) -> ()) {
        let urlSession = URLSession(configuration: .default)
        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask?.resume()
        
        webSocketTask?.receive { result in
            switch result {
            case .failure(let error):
                errorHandler(error)
            case .success(let message):
                successHandler(message)
            }
        }
    }
    
    public func pingWebSocket(errorHandler: @escaping (Error) -> ()) {
        webSocketTask?.sendPing { error in
            guard let error = error else { return }
            errorHandler(error)
        }
    }
    
    public func sendMessageToWebSocket(message: URLSessionWebSocketTask.Message, errorHandler: @escaping (Error) -> ()) {
        webSocketTask?.send(message) { error in
            guard let error = error else { return }
            errorHandler(error)
        }
    }
}
