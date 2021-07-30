//
//  PlanningJoinSetupViewModelTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/24.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class PlanningJoinSetupViewModelTests: XCTestCase {
    
    func testInputValidWhenAllInputsHaveValues() {
        // Given: A viewModel
        let viewModel = PlanningJoinSetupViewModel()
        
        // When: All inputs have values
        viewModel.sessionCode = "012345"
        viewModel.participantName = "Test"
        
        // Then: The input is valid
        XCTAssertTrue(viewModel.inputValid)
    }
    
    func testInputValidWhenParticipantNameIsEmpty() {
        // Given: A viewModel
        let viewModel = PlanningJoinSetupViewModel()
        
        // When: All inputs have values except participantName
        viewModel.sessionCode = "012345"
        viewModel.participantName = ""
        
        // Then: The input is not valid
        XCTAssertFalse(viewModel.inputValid)
    }
    
    func testInputValidWhenSessionCodeIsEmpty() {
        // Given: A viewModel
        let viewModel = PlanningJoinSetupViewModel()
        
        // When: All inputs have valid values except sessionCode
        viewModel.sessionCode = "01234"
        viewModel.participantName = "Test"
        
        // Then: The input is not valid
        XCTAssertFalse(viewModel.inputValid)
    }

}
