//
//  PlanningJoinSessionLandingService.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

protocol PlanningJoinSessionLandingServiceProtocol {
    func startSession() -> AnyPublisher<Result<PlanningCommands.JoinReceive, NetworkError>, NetworkCloseError>
    func sendCommand(_ command: PlanningCommands.JoinSend) throws
}

class PlanningJoinSessionLandingService: PlanningJoinSessionLandingServiceProtocol {
    private var sessionHandler: PlanningSessionNetworkHandler<PlanningCommands.JoinSend, PlanningCommands.JoinReceive>
    
    init() {
        sessionHandler = PlanningSessionNetworkHandler<PlanningCommands.JoinSend, PlanningCommands.JoinReceive>()
    }
    
    func startSession() -> AnyPublisher<Result<PlanningCommands.JoinReceive, NetworkError>, NetworkCloseError> {
        return sessionHandler.startSession(webSocketURL: URLCenter.shared.planningJoinWSURL)
    }
    
    func sendCommand(_ command: PlanningCommands.JoinSend) throws {
        try sessionHandler.send(command: command)
    }
}
