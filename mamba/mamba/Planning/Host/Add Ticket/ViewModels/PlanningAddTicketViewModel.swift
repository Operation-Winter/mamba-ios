//
//  PlanningAddTicketViewModel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

class PlanningAddTicketViewModel: ObservableObject {
    @Published var ticketIdentifier: String = ""
    @Published var ticketDescription: String = ""
    
    var isInputValid: Bool {
        !ticketIdentifier.isEmpty
    }
}
