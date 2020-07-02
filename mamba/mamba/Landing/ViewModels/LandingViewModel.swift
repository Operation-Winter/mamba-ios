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
        .planningHost,
        .planningJoin,
        .retroHost,
        .retroJoin
    ]
    
    private(set) var chunkedLandingItems: [[LandingItem]]
    
    init() {
        chunkedLandingItems = landingItems.chunked(into: 2)
    }
}
