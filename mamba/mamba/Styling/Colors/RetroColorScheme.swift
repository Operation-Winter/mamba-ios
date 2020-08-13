//
//  RetroColorScheme.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct RetroColorScheme: ColorScheme {
    func primary() -> UIColor {
        return UIColor(red: 65 / 255, green: 211 / 255, blue: 189 / 255, alpha: 1)
    }
    
    func secondary() -> UIColor {
        return UIColor(red: 44 / 255, green: 66 / 255, blue: 81 / 255, alpha: 1)
    }
    
    func tertiary() -> UIColor {
        return UIColor(red: 209 / 255, green: 214 / 255, blue: 70 / 255, alpha: 1)
    }
    
    func qauternary() -> UIColor {
        return UIColor(red: 162 / 255, green: 132 / 255, blue: 151 / 255, alpha: 1)
    }
    
    func quinary() -> UIColor {
        return UIColor(red: 64 / 255, green: 120 / 255, blue: 153 / 255, alpha: 1)
    }
    
    func accent() -> UIColor {
        return primary()
    }
}
