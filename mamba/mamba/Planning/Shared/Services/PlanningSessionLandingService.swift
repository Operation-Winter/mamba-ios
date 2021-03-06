//
//  PlanningSessionService.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

class PlanningSessionLandingService<Send: Encodable, Receive: Decodable> {
    private var sessionHandler = PlanningSessionNetworkHandler<Send, Receive>()
    private var sessionURL: URL
    
    var connectionStatusPublisher: AnyPublisher<Bool, Never>? {
        sessionHandler.connectionStatusPublisher
    }
    
    init(sessionURL: URL) {
        self.sessionURL = sessionURL
    }
    
    func configure(sessionHandler: PlanningSessionNetworkHandler<Send, Receive>) {
        self.sessionHandler = sessionHandler
    }
    
    func startSession() -> AnyPublisher<Result<Receive, NetworkError>, NetworkCloseError> {
        return sessionHandler.start(webSocketURL: sessionURL)
    }
    
    func send(command: Send) throws {
        try sessionHandler.send(command: command)
    }
    
    func close() {
        sessionHandler.close()
    }
}
