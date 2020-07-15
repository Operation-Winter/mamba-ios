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
    
    private var cancellable: AnyCancellable?
    
    func sendCommand() {
        cancellable = MambaNetworking.shared.startPlanningHostSession()
            .sink(receiveCompletion: { (error) in
                print(error)
            }, receiveValue: { (command) in
                print(command)
            })
        try? MambaNetworking.shared.send(command: .setupSession(SetupSessionCommand(sessionName: "Test session")))
    }
}
