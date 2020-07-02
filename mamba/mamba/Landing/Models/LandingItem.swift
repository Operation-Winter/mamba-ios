//
//  LandingItem.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/02.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

enum LandingItem {
    case planningHost
    case planningJoin
    case retroHost
    case retroJoin
    
    var imageName: String {
        switch self {
        case .planningHost: return "PlanningHost"
        case .planningJoin: return "PlanningJoin"
        case .retroHost: return "RetroHost"
        case .retroJoin: return "RetroJoin"
        }
    }
    
    var titleKey: LocalizedStringKey {
        switch self {
        case .planningHost: return "LANDING_PLANNING_HOST"
        case .planningJoin: return "LANDING_PLANNING_JOIN"
        case .retroHost: return "LANDING_RETRO_HOST"
        case .retroJoin: return "LANDING_RETRO_JOIN"
        }
    }
}
