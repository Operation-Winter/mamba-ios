//
//  PlanningAddTicketMessage.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public struct PlanningAddTicketMessage: Codable {
    public let identifier: String
    public let description: String
}
