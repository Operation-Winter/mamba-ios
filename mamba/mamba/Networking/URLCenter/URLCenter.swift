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
        networkEnvironment.baseURL
    }
    
    var webSocketBaseURL: URL {
        networkEnvironment.webSocketBaseURL
    }
    
    private init() {
        #if targetEnvironment(simulator)
        networkEnvironment = LocalNetworkEnvironment()
        #else
        networkEnvironment = DevelopmentNetworkEnvironment()
        #endif
        
        Log.log(level: .debug, category: .networking, message: "%@: Networking environment: %@", args: String(describing: URLCenter.self), String(describing: networkEnvironment))
    }
}
