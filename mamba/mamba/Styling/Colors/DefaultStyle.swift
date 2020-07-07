//
//  DefaultStyle.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

enum Product {
    case planning
    case retro
}

protocol ColorScheme {
    func primary() -> Color
    func secondary() -> Color
    func tertiary() -> Color
    func qauternary() -> Color
    func quinary() -> Color
    func accent() -> Color
}

class DefaultStyle {
    static let shared = DefaultStyle()
    private(set) var colorScheme: ColorScheme = PlanningColorScheme()
    
    private init() { }
    
    func setColorScheme(product: Product) {
        switch product {
        case .planning:
            colorScheme = PlanningColorScheme()
        case .retro:
            colorScheme = RetroColorScheme()
        }
    }
}
