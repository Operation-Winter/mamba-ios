//
//  AvailableCard.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/14.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import MambaNetworking

class AvailableCard: Identifiable, ObservableObject {
    let card: PlanningCard
    @Published var selected: Bool
    
    init(card: PlanningCard, selected: Bool) {
        self.card = card
        self.selected = selected
    }
}
