//
//  MambaNetworkingClosingError.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/19.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public enum NetworkCloseError: Error {
    case failure(Error?)
    
    public var errorCode: String {
        switch self {
        case .failure: return "3000"
        }
    }
    
    public var errorDescription: String {
        switch self {
        case .failure(let error):
            return error?.localizedDescription ?? "Something went wrong with the connection"
        }
    }
}
