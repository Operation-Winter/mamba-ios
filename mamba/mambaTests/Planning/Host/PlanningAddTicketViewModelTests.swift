//
//  PlanningAddTicketViewModelTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/24.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class PlanningAddTicketViewModelTests: XCTestCase {

    func testInputValidWhenAllValuesNotEmpty() {
        // Given: an add ticket viewModel
        let viewModel = PlanningAddTicketViewModel()
        
        // When: all values are mapped
        viewModel.ticketIdentifier = "Test"
        viewModel.ticketDescription = "Test"
        
        // Then: the input is valid
        XCTAssertTrue(viewModel.isInputValid)
    }
    
    func testInputValidWhenIdentifierIsEmpty() {
        // Given: an add ticket viewModel
        let viewModel = PlanningAddTicketViewModel()
        
        // When: some values are mapped
        viewModel.ticketIdentifier = ""
        viewModel.ticketDescription = "Test"
        
        // Then: the input is not valid
        XCTAssertFalse(viewModel.isInputValid)
    }
    
    func testInputValidWhenDescriptionIsEmpty() {
        // Given: an add ticket viewModel
        let viewModel = PlanningAddTicketViewModel()
        
        // When: some values are mapped
        viewModel.ticketIdentifier = "Test"
        viewModel.ticketDescription = ""
        
        // Then: the input is not valid
        XCTAssertFalse(viewModel.isInputValid)
    }

}
