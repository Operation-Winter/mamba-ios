//
//  PlanningVoteMessage.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public struct PlanningVoteMessage: Codable {
    let ticketId: String
    let selectedCard: PlanningCard
}
