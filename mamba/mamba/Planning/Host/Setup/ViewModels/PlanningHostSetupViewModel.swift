//
//  PlanningHostSetupViewModel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

class PlanningHostSetupViewModel: ObservableObject {
    @Published var sessionName: String = ""
    
    
    //            switch result {
    //            case .failure(let error):
    //                print("Error in receiving message: \(error)")
    //            case .success(let message):
    //                switch message {
    //                case .string(let text):
    //                    print("Received string: \(text)")
    //                case .data(let data):
    //                    print("Received data: \(data)")
    //                @unknown default:
    //                    print("Unknown message type")
    //                }
    //            }
}
