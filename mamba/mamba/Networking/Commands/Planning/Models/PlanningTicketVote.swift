//
//  PlanningTicketVote.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public class PlanningTicketVote: Codable {
    public private(set) var user: PlanningParticipant
    public private(set) var selectedCard: PlanningCard?
    
    init(user: PlanningParticipant, selectedCard: PlanningCard?) {
        self.user = user
        self.selectedCard = selectedCard
    }
}
