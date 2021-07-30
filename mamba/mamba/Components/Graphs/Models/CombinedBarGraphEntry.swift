//
//  CombinedBarGraphEntry.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

class CombinedBarGraphEntry: Identifiable {
    let title: String
    let count: Int
    
    init(title: String, count: Int) {
        self.title = title
        self.count = count
    }
}
