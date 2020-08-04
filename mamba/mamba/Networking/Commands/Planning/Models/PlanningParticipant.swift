//
//  PlanningParticipant.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

class PlanningParticipant: Codable, Identifiable {
    private(set) var id: String
    private(set) var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
