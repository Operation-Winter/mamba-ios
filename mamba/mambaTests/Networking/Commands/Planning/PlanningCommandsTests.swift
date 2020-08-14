//
//  PlanningCommandsTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class PlanningCommandsTests: XCTestCase {

    func testHostKeyRawValues() {
        // When: Host command keys are mapped
        let hostKeys = PlanningCommands.HostKey.allCases
        
        // Then: the keys match expected values
        for (index, key) in hostKeys.enumerated() {
            XCTAssertEqual(key.rawValue, Expected.hostKeys.element(at: index))
        }
    }
    
    func testJoinKeyRawValues() {
        // When: Join command keys are mapped
        let joinKeys = PlanningCommands.JoinKey.allCases
        
        // Then: the keys match expected values
        for (index, key) in joinKeys.enumerated() {
            XCTAssertEqual(key.rawValue, Expected.joinKeys.element(at: index))
        }
    }

}

fileprivate class Expected {
    static let hostKeys = [
        "START_SESSION",
        "ADD_TICKET",
        "SKIP_VOTE",
        "REMOVE_PARTICIPANT",
        "END_SESSION",
        "FINISH_VOTING",
        "RECONNECT",
        "REVOTE",
        "NONE_STATE",
        "VOTING_STATE",
        "FINISHED_STATE",
        "INVALID_COMMAND"
    ]
    
    static let joinKeys = [
        "JOIN_SESSION",
        "VOTE",
        "LEAVE_SESSION",
        "RECONNECT",
        "NONE_STATE",
        "VOTING_STATE",
        "FINISHED_STATE",
        "INVALID_COMMAND",
        "INVALID_SESSION",
        "REMOVE_PARTICIPANT",
        "END_SESSION"
    ]
}
