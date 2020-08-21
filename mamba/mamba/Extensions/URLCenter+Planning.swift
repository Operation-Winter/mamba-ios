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
    
    func planningSessionCode(from url: String) -> String? {
        guard
            let url = URL(string: url),
            let baseQRURL = url.baseURL,
            baseURL == baseQRURL,
            let feature = url.pathComponents.element(at: 1),
            feature == "planning",
            let type = url.pathComponents.element(at: 2),
            type == "join",
            let sessionCode = url.pathComponents.element(at: 3),
            sessionCode.count == 6
        else { return nil }
        
        return sessionCode
    }
}
