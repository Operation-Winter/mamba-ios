//
//  UIColor+Extensions.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import UIKit

extension UIColor {
    func lighter(by percentage: CGFloat = 10.0) -> UIColor {
        return self.adjust(by: abs(percentage))
    }
    
    func darker(by percentage: CGFloat = 10.0) -> UIColor {
        return self.adjust(by: -abs(percentage))
    }
    
//    func adjust(by percentage: CGFloat) -> UIColor {
//        var alpha, hue, saturation, brightness, red, green, blue, white : CGFloat
//        (alpha, hue, saturation, brightness, red, green, blue, white) = (0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
//
//        let multiplier = percentage / 100.0
//
//        if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
//            let newBrightness: CGFloat = max(min(brightness + multiplier*brightness, 1.0), 0.0)
//            return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
//        } else if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
//            let newRed: CGFloat = min(max(red + multiplier*red, 0.0), 1.0)
//            let newGreen: CGFloat = min(max(green + multiplier*green, 0.0), 1.0)
//            let newBlue: CGFloat = min(max(blue + multiplier*blue, 0.0), 1.0)
//            return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: alpha)
//        } else if self.getWhite(&white, alpha: &alpha) {
//            let newWhite: CGFloat = (white + multiplier*white)
//            return UIColor(white: newWhite, alpha: alpha)
//        }
//
//        return self
//    }
    
    func adjust(by percentage: CGFloat = 30.0) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            if b < 1.0 {
                let newB: CGFloat = max(min(b + (percentage/100.0)*b, 1.0), 0.0)
                return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
            } else {
                let newS: CGFloat = min(max(s - (percentage/100.0)*s, 0.0), 1.0)
                return UIColor(hue: h, saturation: newS, brightness: b, alpha: a)
            }
        }
        return self
    }
}
