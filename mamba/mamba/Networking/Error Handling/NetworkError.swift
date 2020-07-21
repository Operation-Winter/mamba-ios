//
//  MambaNetworkingError.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/19.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case decodingTypeMistmatch(String)
    case decodingValueNotFound(String)
    case decodingKeyNotFound(String)
    case decodingDataCorrupted(String)
    case unknownDecodingError(DecodingError)
    case unknownError(Error)
    
    static func parseDecodingError(_ error: DecodingError) -> NetworkError {
        switch error {
        case .typeMismatch(_, let context): return .decodingTypeMistmatch(context.debugDescription)
        case .valueNotFound(_, let context): return .decodingValueNotFound(context.debugDescription)
        case .keyNotFound(_, let context): return .decodingKeyNotFound(context.debugDescription)
        case .dataCorrupted(let context): return .decodingDataCorrupted(context.debugDescription)
        @unknown default: return .unknownDecodingError(error)
        }
    }
}
