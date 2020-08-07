//
//  PlanningTicket.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

class PlanningTicket: Codable {
    private(set) var identifier: String
    private(set) var description: String
    
    init(identifier: String, description: String) {
        self.identifier = identifier
        self.description = description
    }
}
