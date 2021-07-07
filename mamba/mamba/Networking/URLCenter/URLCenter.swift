//
//  URLCenter.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public class URLCenter {
    public static let shared = URLCenter()
    private var environmentType: NetworkEnvironmentType

    private var networkEnvironment: NetworkEnvironment {
        makeNetworkEnvironment(environmentType)
    }
    
    public var baseURL: URL {
        networkEnvironment.baseURL
    }
    
    public var webSocketBaseURL: URL {
        networkEnvironment.webSocketBaseURL
    }
    
    private init() {
        #if targetEnvironment(simulator)
        environmentType = .development
        #else
        environmentType = .development
        #endif
        Log.networking.logger.debug("Networking environment: \(String(describing: URLCenter.self)) \(String(describing: self.networkEnvironment.webSocketBaseURL))")
    }
    
    public func makeNetworkEnvironment(_ environment: NetworkEnvironmentType) -> NetworkEnvironment {
        switch environment {
        case .local:
            return LocalNetworkEnvironment()
        case .development:
            return DevelopmentNetworkEnvironment()
        case .production:
            return DevelopmentNetworkEnvironment()
        }
    }
}
