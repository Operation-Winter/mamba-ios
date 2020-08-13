//
//  PlanningColorScheme.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningColorScheme: ColorScheme {
    func primary() -> UIColor {
        return UIColor(red: 56 / 255, green: 2 / 255, blue: 59 / 255, alpha: 1)
    }
    
    func secondary() -> UIColor {
        return UIColor(red: 162 / 255, green: 136 / 255, blue: 227 / 255, alpha: 1)
    }
    
    func tertiary() -> UIColor {
        return UIColor(red: 187 / 255, green: 213 / 255, blue: 237 / 255, alpha: 1)
    }
    
    func qauternary() -> UIColor {
        return UIColor(red: 206 / 255, green: 253 / 255, blue: 255 / 255, alpha: 1)
    }
    
    func quinary() -> UIColor {
        return UIColor(red: 204 / 255, green: 255 / 255, blue: 203 / 255, alpha: 1)
    }
    
    func accent() -> UIColor {
        return secondary()
    }
}
