//
//  URLCenter.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

class URLCenter {
    static let shared = URLCenter()
    private let networkEnvironment: NetworkEnvironment

    var baseURL: URL {
        return networkEnvironment.baseURL
    }
    
    var webSocketBaseURL: URL {
        return networkEnvironment.webSocketBaseURL
    }
    
    private init() {
        #if targetEnvironment(simulator)
        networkEnvironment = LocalNetworkEnvironment()
        #else
        networkEnvironment = DevelopmentNetworkEnvironment()
        #endif
    }
}
