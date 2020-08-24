//
//  MockPlanningSessionLandingService.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/24.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine
@testable import Mamba

class MockPlanningSessionLandingService<Send: Encodable, Receive: Decodable>: PlanningSessionLandingService<Send, Receive> {
    var closeCounter = 0
    var sendCommandCounter = 0
    
    override func send(command: Send) throws {
        try super.send(command: command)
        sendCommandCounter += 1
    }
    
    override func close() {
        super.close()
        closeCounter += 1
    }
}
