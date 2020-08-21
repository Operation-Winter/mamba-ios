//
//  DevelopmentNetworkEnvironment.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

class DevelopmentNetworkEnvironment: NetworkEnvironment {
    var baseURL: URL = {
        guard let url = URL(string: "https://mamba.armandkamffer.co.za") else { fatalError() }
        return url
    }()
    
    var webSocketBaseURL: URL = {
        guard let url = URL(string: "wss://mamba.armandkamffer.co.za:82") else { fatalError() }
        return url
    }()
}
