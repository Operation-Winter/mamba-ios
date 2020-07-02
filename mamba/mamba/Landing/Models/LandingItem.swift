//
//  LandingItem.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/02.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct LandingItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: LocalizedStringKey
}
