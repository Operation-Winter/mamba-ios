//
//  PlanningStartSessionMessage.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public struct PlanningStartSessionMessage: Codable {
    public let sessionName: String
    public let availableCards: [PlanningCard]
}
