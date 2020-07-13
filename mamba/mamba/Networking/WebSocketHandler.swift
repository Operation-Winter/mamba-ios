//
//  WebSocketHandler.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

class WebSocketHandler {
    public var subject = PassthroughSubject<URLSessionWebSocketTask.Message, Error>()
    private var webSocketTask: URLSessionWebSocketTask
    
    init(url: URL) {
        let urlSession = URLSession(configuration: .ephemeral)
        self.webSocketTask = urlSession.webSocketTask(with: url)
    }
    
    public func startSession() {
        webSocketTask.resume()
        
        webSocketTask.receive { result in
            switch result {
            case .failure(let error):
                self.subject.send(completion: .failure(error))
            case .success(let message):
                self.subject.send(message)
            }
        }
    }
    
    public func pingWebSocket() {
        webSocketTask.sendPing { error in
            guard let error = error else { return }
            self.subject.send(completion: .failure(error))
        }
    }
    
    public func sendMessageToWebSocket(message: URLSessionWebSocketTask.Message) {
        webSocketTask.send(message) { error in
            guard let error = error else { return }
            self.subject.send(completion: .failure(error))
        }
    }
    
    public func closeWebSocket() {
        webSocketTask.cancel(with: .normalClosure, reason: nil)
        self.subject.send(completion: .finished)
    }
}
