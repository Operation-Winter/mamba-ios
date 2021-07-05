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
    case socketTimeOut
    
    public var errorCode: String {
        switch self {
        case .socketReceiveFailure: return "3000"
        case .socketPingFailure: return "3001"
        case .socketSendFailure: return "3002"
        case .socketTimeOut: return "3003"
        }
    }
    
    public var errorDescription: String {
        switch self {
        case .socketReceiveFailure(let error): return error.localizedDescription
        case .socketPingFailure(let error): return error.localizedDescription
        case .socketSendFailure(let error): return error.localizedDescription
        case .socketTimeOut: return "A timeout has occured while trying to connect to the server"
        }
    }
}
