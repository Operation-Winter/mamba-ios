//
//  PlanningHostSetupViewModelTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/24.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class PlanningHostSetupViewModelTests: XCTestCase {

    func testInputValidWhenAllInputsArePopulated() {
        // Given: a host setup viewModel
        let viewModel = PlanningHostSetupViewModel()
        
        // When: session name and available cards have valid inputs
        viewModel.sessionName = "Test"
        viewModel.availableCards = [AvailableCard(card: .coffee, selected: true)]
        
        // Then: the input is valid
        XCTAssertTrue(viewModel.inputValid)
    }
    
    func testInputValidWhenSessionNameIsNotPopulated() {
        // Given: a host setup viewModel
        let viewModel = PlanningHostSetupViewModel()
        
        // When: session name and available cards are mapped
        viewModel.sessionName = ""
        viewModel.availableCards = [AvailableCard(card: .coffee, selected: true)]
        
        // Then: the input is valid
        XCTAssertFalse(viewModel.inputValid)
    }
    
    func testInputValidWhenNoCardsAreSelected() {
        // Given: a host setup viewModel
        let viewModel = PlanningHostSetupViewModel()
        
        // When: session name and available cards are mapped
        viewModel.sessionName = "Test"
        viewModel.availableCards = [AvailableCard(card: .coffee, selected: false)]
        
        // Then: the input is not valid
        XCTAssertFalse(viewModel.inputValid)
    }
    
    func testSelectedCardCountTitleAll() {
        // Given: a host setup viewModel
        let viewModel = PlanningHostSetupViewModel()
        
        // When: all cards are selected
        viewModel.availableCards = [
            AvailableCard(card: .coffee, selected: true),
            AvailableCard(card: .one, selected: true),
        ]
        
        // Then: the title matches the localized string
        XCTAssertEqual(viewModel.selectedCardsCountTitle, NSLocalizedString("ALL", comment: "All"))
    }
    
    func testSelectedCardCountTitleSome() {
        // Given: a host setup viewModel
        let viewModel = PlanningHostSetupViewModel()
        
        // When: all cards are selected
        viewModel.availableCards = [
            AvailableCard(card: .coffee, selected: false),
            AvailableCard(card: .one, selected: true),
        ]
        
        // Then: the title matches the localized string
        XCTAssertEqual(viewModel.selectedCardsCountTitle, NSLocalizedString("SOME", comment: "Some"))
    }
    
    func testSelectedCardCountTitleNone() {
        // Given: a host setup viewModel
        let viewModel = PlanningHostSetupViewModel()
        
        // When: all cards are selected
        viewModel.availableCards = [
            AvailableCard(card: .coffee, selected: false),
            AvailableCard(card: .one, selected: false),
        ]
        
        // Then: the title matches the localized string
        XCTAssertEqual(viewModel.selectedCardsCountTitle, NSLocalizedString("NONE", comment: "None"))
    }

}
