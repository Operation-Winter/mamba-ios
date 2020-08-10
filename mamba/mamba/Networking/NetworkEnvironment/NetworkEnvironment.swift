//
//  NetworkEnvironment.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public protocol NetworkEnvironment {
    var baseURL: URL { get }
    var webSocketBaseURL: URL { get }
}
