//
//  PlanningInvalidCommandMessage.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public struct PlanningInvalidCommandMessage: Codable {
    public let code: String
    public let description: String
}
