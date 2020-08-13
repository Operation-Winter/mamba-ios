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
    func primary() -> UIColor
    func secondary() -> UIColor
    func tertiary() -> UIColor
    func qauternary() -> UIColor
    func quinary() -> UIColor
    func accent() -> UIColor
}

class DefaultStyle {
    static let shared = DefaultStyle()
    private var colorScheme: ColorScheme = PlanningColorScheme()
    
    private init() { }
    
    func setColorScheme(product: Product) {
        switch product {
        case .planning:
            colorScheme = PlanningColorScheme()
        case .retro:
            colorScheme = RetroColorScheme()
        }
    }
    
    var primary: Color {
        Color(colorScheme.primary())
    }
    
    var uiPrimary: UIColor {
        colorScheme.primary()
    }
    
    var secondary: Color {
        Color(colorScheme.secondary())
    }
    
    var tertiary: Color {
        Color(colorScheme.tertiary())
    }
    
    var qauternary: Color {
        Color(colorScheme.qauternary())
    }
    
    var quinary: Color {
        Color(colorScheme.quinary())
    }
    
    var accent: Color {
        Color(colorScheme.accent())
    }

    var systemGray: Color {
        Color(UIColor.systemGray)
    }
    
    var systemGray2: Color {
        Color(UIColor.systemGray2)
    }
    
    var systemGray3: Color {
        Color(UIColor.systemGray3)
    }
    
    var systemGray4: Color {
        Color(UIColor.systemGray4)
    }
    
    var systemGray5: Color {
        Color(UIColor.systemGray5)
    }
    
    var systemGray6: Color {
        Color(UIColor.systemGray6)
    }
    
    var errorRed: Color {
        .red
    }
}
