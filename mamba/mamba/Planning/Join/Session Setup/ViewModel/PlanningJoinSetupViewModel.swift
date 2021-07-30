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
    @Published var sessionCode: String = ""

    var inputValid: Bool {
        !participantName.isEmpty
            && sessionCode.count == 6
            && NumberFormatter().number(from: sessionCode) != nil
    }
}
