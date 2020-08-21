//
//  URLCenter+Planning.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

extension URLCenter {
    private var planningHostPath: String { "planning/host" }
    private var planningJoinPath: String { "planning/join" }
    
    var planningJoinURL: URL {
        baseURL.appendingPathComponent(planningJoinPath)
    }
    
    var planningHostWSURL: URL {
        webSocketBaseURL.appendingPathComponent(planningHostPath)
    }
    
    var planningJoinWSURL: URL {
        webSocketBaseURL.appendingPathComponent(planningJoinPath)
    }
    
    func planningJoinURL(sessionCode: String) -> URL {
        planningJoinURL.appendingPathComponent(sessionCode)
    }
}
