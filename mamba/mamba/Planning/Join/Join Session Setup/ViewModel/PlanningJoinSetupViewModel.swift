//
//  PlanningJoinSetupViewModel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/31.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

class PlanningJoinSetupViewModel: ObservableObject {
    @Published var participantName: String = ""
    @Published var sessionCode1: Int?
    @Published var sessionCode2: Int?
    @Published var sessionCode3: Int?
    @Published var sessionCode4: Int?
    @Published var sessionCode5: Int?
    @Published var sessionCode6: Int?
    
    var sessionCode: String? {
        guard
            let code1 = sessionCode1,
            let code2 = sessionCode2,
            let code3 = sessionCode3,
            let code4 = sessionCode4,
            let code5 = sessionCode5,
            let code6 = sessionCode6
        else {
            return nil
        }
        
        return "\(code1)\(code2)\(code3)\(code4)\(code5)\(code6)"
    }
}
