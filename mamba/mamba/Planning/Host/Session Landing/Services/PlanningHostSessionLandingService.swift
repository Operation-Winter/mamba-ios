//
//  PlanningHostSessionLandingService.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

protocol PlanningHostSessionLandingServiceProtocol {
    
}

class PlanningHostSessionLandingService: PlanningHostSessionLandingServiceProtocol {
    private var sessionHandler: PlanningHostSessionNetworkHandler
    
    private var cancellable: AnyCancellable?
    
    init() {
        sessionHandler = PlanningHostSessionNetworkHandler()
    }
    
    func startSession() {
        cancellable = sessionHandler.startSession().sink(receiveCompletion: { networkError in
            print(networkError)
        }, receiveValue: { result in
            switch result {
            case .success(let command):
                print(command)
            case .failure(let error):
                print(error)
            }
        })
    }
}
