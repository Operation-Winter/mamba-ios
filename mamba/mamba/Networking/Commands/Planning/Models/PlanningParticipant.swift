//
//  PlanningParticipant.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public class PlanningParticipant: Codable, Identifiable {
    public private(set) var id: String
    public private(set) var name: String
    public var selectedCard: PlanningCard? = nil
    public var skipped: Bool? = false
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
