//
//  PlanningTicket.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public class PlanningTicket: Codable {
    public private(set) var identifier: String
    public private(set) var description: String
    
    public init(identifier: String, description: String) {
        self.identifier = identifier
        self.description = description
    }
}
