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
        get {
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
        set {
            guard let newValue = newValue else { return }
            let sessionCodeArray: [String] = newValue.map { String($0) }
            
            if let code = sessionCodeArray.element(at: 0) {
                sessionCode1 = NumberFormatter().number(from: code)?.intValue
            }
            if let code = sessionCodeArray.element(at: 1) {
                sessionCode2 = NumberFormatter().number(from: code)?.intValue
            }
            if let code = sessionCodeArray.element(at: 2) {
                sessionCode3 = NumberFormatter().number(from: code)?.intValue
            }
            if let code = sessionCodeArray.element(at: 3) {
                sessionCode4 = NumberFormatter().number(from: code)?.intValue
            }
            if let code = sessionCodeArray.element(at: 4) {
                sessionCode5 = NumberFormatter().number(from: code)?.intValue
            }
            if let code = sessionCodeArray.element(at: 5) {
                sessionCode6 = NumberFormatter().number(from: code)?.intValue
            }
        }
    }
    
    var inputValid: Bool {
        !participantName.isEmpty
            && sessionCode?.count == 6
    }
}
