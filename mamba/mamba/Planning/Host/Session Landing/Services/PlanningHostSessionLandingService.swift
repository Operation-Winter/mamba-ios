//
//  PlanningHostSessionLandingService.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

protocol PlanningHostSessionLandingServiceProtocol {
    func startSession() -> AnyPublisher<Result<PlanningCommands.HostReceive, NetworkError>, NetworkCloseError>
    func sendCommand(_ command: PlanningCommands.HostSend) throws
}

class PlanningHostSessionLandingService: PlanningHostSessionLandingServiceProtocol {
    private var sessionHandler: PlanningHostSessionNetworkHandler

    init() {
        sessionHandler = PlanningHostSessionNetworkHandler()
    }
    
    func startSession() -> AnyPublisher<Result<PlanningCommands.HostReceive, NetworkError>, NetworkCloseError> {
        return sessionHandler.startSession()
    }
    
    func sendCommand(_ command: PlanningCommands.HostSend) throws {
        try sessionHandler.send(command: command)
    }
}