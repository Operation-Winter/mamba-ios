//
//  MambaNetworkingClosingError.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/19.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public enum NetworkCloseError: Error {
    case socketReceiveFailure(Error)
    case socketPingFailure(Error)
    case socketSendFailure(Error)
    
    public var errorCode: String {
        switch self {
        case .socketReceiveFailure(_): return "3000"
        case .socketPingFailure(_): return "3001"
        case .socketSendFailure(_): return "3002"
        }
    }
    
    public var errorDescription: String {
        switch self {
        case .socketReceiveFailure(let error): return error.localizedDescription
        case .socketPingFailure(let error): return error.localizedDescription
        case .socketSendFailure(let error): return error.localizedDescription
        }
    }
}
