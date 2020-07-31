//
//  JoinSessionCommand.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/31.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public struct JoinSessionMessage: Codable {
    let sessionCode: String
    let participantName: String
}
