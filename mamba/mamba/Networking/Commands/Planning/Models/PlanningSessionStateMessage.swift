//
//  PlanningSessionStateMessage.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/30.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public struct PlanningSessionStateMessage: Codable {
    let sessionCode: String
    let sessionName: String
    let availableCards: [PlanningCard]
    let participants: [PlanningParticipant]
    let ticket: PlanningTicket?
}
