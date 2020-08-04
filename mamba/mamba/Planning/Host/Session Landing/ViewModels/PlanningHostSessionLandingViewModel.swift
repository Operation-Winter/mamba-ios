//
//  PlanningHostSessionLandingViewModel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

class PlanningHostSessionLandingViewModel: ObservableObject {
    private var service: PlanningHostSessionLandingServiceProtocol
    
    @Published var title: String
    
    init() {
        self.service = PlanningHostSessionLandingService()
        self.title = "Test"
    }
}
