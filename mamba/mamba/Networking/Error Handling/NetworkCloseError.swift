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
}
