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

    func testSessionCodeSetterValidValue() {
        // Given: A viewModel
        let viewModel = PlanningJoinSetupViewModel()
        
        // When: Session code value is set
        viewModel.sessionCode = "012345"
        
        // Then: The session code values match the expected values
        XCTAssertEqual(viewModel.sessionCode1, 0)
        XCTAssertEqual(viewModel.sessionCode2, 1)
        XCTAssertEqual(viewModel.sessionCode3, 2)
        XCTAssertEqual(viewModel.sessionCode4, 3)
        XCTAssertEqual(viewModel.sessionCode5, 4)
        XCTAssertEqual(viewModel.sessionCode6, 5)
    }
    
    func testSessionCodeSetterNotValidValue() {
        // Given: A viewModel
        let viewModel = PlanningJoinSetupViewModel()
        
        // When: Session code value is set
        viewModel.sessionCode = "01234"
        
        // Then: The session code values match the expected values
        XCTAssertEqual(viewModel.sessionCode1, 0)
        XCTAssertEqual(viewModel.sessionCode2, 1)
        XCTAssertEqual(viewModel.sessionCode3, 2)
        XCTAssertEqual(viewModel.sessionCode4, 3)
        XCTAssertEqual(viewModel.sessionCode5, 4)
        XCTAssertNil(viewModel.sessionCode6)
    }

    func testSessionCodeGetterValidValue() {
        // Given: A viewModel
        let viewModel = PlanningJoinSetupViewModel()
        
        // When: Session code values are set
        viewModel.sessionCode1 = 0
        viewModel.sessionCode2 = 1
        viewModel.sessionCode3 = 2
        viewModel.sessionCode4 = 3
        viewModel.sessionCode5 = 4
        viewModel.sessionCode6 = 5
        
        // Then: The session code matches the expected value
        XCTAssertEqual(viewModel.sessionCode, "012345")
    }
    
    func testSessionCodeGetterNotValidValue() {
        // Given: A viewModel
        let viewModel = PlanningJoinSetupViewModel()
        
        // When: Session code values are set
        viewModel.sessionCode1 = 0
        viewModel.sessionCode2 = 1
        viewModel.sessionCode3 = 2
        viewModel.sessionCode4 = 3
        viewModel.sessionCode5 = 4
        
        // Then: The session code matches the expected value
        XCTAssertNil(viewModel.sessionCode)
    }
    
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
