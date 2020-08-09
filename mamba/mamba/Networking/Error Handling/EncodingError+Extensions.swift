//
//  EncodingError+Extensions.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public extension EncodingError {
    var errorCode: String {
        switch self {
        case .invalidValue(_, _): return "3200"
        @unknown default: return "3105"
        }
    }
    
    var errorCustomDescription: String {
        switch self {
        case .invalidValue(_, _): return "Failed to encode command being sent to session"
        @unknown default: return "Unknown error occured sending command to session"
        }
    }
}
