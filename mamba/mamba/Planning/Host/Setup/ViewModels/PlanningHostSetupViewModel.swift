//
//  PlanningHostSetupViewModel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

class PlanningHostSetupViewModel: ObservableObject {
    @Published var sessionName: String = ""
    
    private var planningHostEvents: AnyCancellable?
    
    init() {
        planningHostEvents = MambaNetworking.shared.startPlanningHostSession()
            .sink(receiveCompletion: { closeError in
                print(closeError)
            }, receiveValue: { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let command):
                    print(command)
                }
                
            })
    }
    
    deinit {
        planningHostEvents?.cancel()
    }
    
    func sendCommand() {
        try? MambaNetworking.shared.send(command: .setupSession(SetupSessionMessage(sessionName: "Cerberus 33")))
    }
}
