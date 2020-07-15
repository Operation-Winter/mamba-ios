//
//  LocalNetworkEnvironment.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

class LocalNetworkEnvironment: NetworkEnvironment {
    var baseURL: URL = {
        guard let url = URL(string: "localhost") else { fatalError() }
        return url
    }()
    
    var webSocketBaseURL: URL = {
        guard let url = URL(string: "ws://localhost") else { fatalError() }
        return url
    }()
}
