//
//  RetroColorScheme.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct RetroColorScheme: ColorScheme {
    func primary() -> Color {
        return Color(red: 65 / 255, green: 211 / 255, blue: 189 / 255)
    }
    
    func secondary() -> Color {
        return Color(red: 44 / 255, green: 66 / 255, blue: 81 / 255)
    }
    
    func tertiary() -> Color {
        return Color(red: 209 / 255, green: 214 / 255, blue: 70 / 255)
    }
    
    func qauternary() -> Color {
        return Color(red: 162 / 255, green: 132 / 255, blue: 151 / 255)
    }
    
    func quinary() -> Color {
        return Color(red: 64 / 255, green: 120 / 255, blue: 153 / 255)
    }
    
    func accent() -> Color {
        return primary()
    }
}
