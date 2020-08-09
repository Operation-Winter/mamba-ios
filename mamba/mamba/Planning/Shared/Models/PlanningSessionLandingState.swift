//
//  PlanningSessionLandingState.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

enum PlanningSessionLandingState {
    case error(PlanningLandingError)
    case loading
    case none
    case voting
    case finishedVoting
}
