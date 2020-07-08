//
//  PlanningColorScheme.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningColorScheme: ColorScheme {
    func primary() -> Color {
        return Color(red: 56 / 255, green: 2 / 255, blue: 59 / 255)
    }
    
    func secondary() -> Color {
        return Color(red: 162 / 255, green: 136 / 255, blue: 227 / 255)
    }
    
    func tertiary() -> Color {
        return Color(red: 187 / 255, green: 213 / 255, blue: 237 / 255)
    }
    
    func qauternary() -> Color {
        return Color(red: 206 / 255, green: 253 / 255, blue: 255 / 255)
    }
    
    func quinary() -> Color {
        return Color(red: 204 / 255, green: 255 / 255, blue: 203 / 255)
    }
    
    func accent() -> Color {
        return secondary()
    }
}
