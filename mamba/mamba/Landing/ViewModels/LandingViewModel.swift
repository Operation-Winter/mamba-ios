//
//  LandingViewModel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/02.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import SwiftUI

class LandingViewModel {
    private(set) var landingItems: [LandingItem] = [
        .planningHost,
        .planningJoin
    ]
    
    private(set) var gridItems: [GridItem] = [
        GridItem(.adaptive(minimum: 300, maximum: 500))
    ]
}
