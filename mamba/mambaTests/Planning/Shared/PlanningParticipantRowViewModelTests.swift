//
//  PlanningParticipantRowViewModelTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/24.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class PlanningParticipantRowViewModelTests: XCTestCase {

    func testBorderWidthHighlighted() {
        // When: RowViewModel with highlighted set to true
        let rowViewModel = PlanningParticipantRowViewModel(participantId: "x", participantName: "Test", highlighted: true)
        
        // Then: the borderwidth is equal to 2
        XCTAssertEqual(rowViewModel.borderWidth, 2)
    }
    
    func testBorderWidthNotHighlighted() {
        // When: RowViewModel with highlighted set to false
        let rowViewModel = PlanningParticipantRowViewModel(participantId: "x", participantName: "Test", highlighted: false)
        
        // Then: the borderwidth is equal to 0
        XCTAssertEqual(rowViewModel.borderWidth, 0)
    }

}
