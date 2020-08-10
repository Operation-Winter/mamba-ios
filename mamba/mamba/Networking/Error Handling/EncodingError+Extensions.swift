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
        case .invalidValue(_, _): return NSLocalizedString("NETWORKING_ERROR_ENCODING_ERROR_INVALID_VALUE_DESCRIPTION", comment: "Localized error description")
        @unknown default: return NSLocalizedString("NETWORKING_ERROR_ENCODING_ERROR_UNKNOWN_DESCRIPTION", comment: "Localized error description")
        }
    }
}
