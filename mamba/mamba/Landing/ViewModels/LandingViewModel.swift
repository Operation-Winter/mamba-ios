//
//  LandingViewModel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/02.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

class LandingViewModel {
    private(set) var landingItems: [LandingItem] = [
        LandingItem(imageName: "PlanningHost", title: "LANDING_PLANNING_HOST"),
        LandingItem(imageName: "PlanningJoin", title: "LANDING_PLANNING_JOIN"),
        LandingItem(imageName: "RetroHost", title: "LANDING_RETRO_HOST"),
        LandingItem(imageName: "RetroJoin", title: "LANDING_RETRO_JOIN")
    ]
}
