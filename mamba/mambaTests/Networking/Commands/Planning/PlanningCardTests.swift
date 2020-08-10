//
//  PlanningCardTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/10.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class PlanningCardTests: XCTestCase {

    func testRawValues() {
        // When: PlanningCard values are mapped
        let planningCards = PlanningCard.allCases
        
        // Then: the keys match expected values
        for (index, key) in planningCards.enumerated() {
            XCTAssertEqual(key.rawValue, Expected.cardKeys.element(at: index))
        }
    }

    func testImageNames() {
        // When: PlanningCard values are mapped
        let planningCards = PlanningCard.allCases
        
        // Then: the keys match expected values
        for (index, key) in planningCards.enumerated() {
            XCTAssertEqual(key.imageName, Expected.cardImageNames.element(at: index))
        }
    }
}

fileprivate class Expected {
    static let cardKeys = [
        "ZERO",
        "ONE",
        "TWO",
        "THREE",
        "FIVE",
        "EIGHT",
        "THIRTEEN",
        "TWENTY",
        "FOURTY",
        "HUNDRED",
        "QUESTION",
        "COFFEE"
    ]
    
    static let cardImageNames = [
        "PlanningCardZero",
        "PlanningCardOne",
        "PlanningCardTwo",
        "PlanningCardThree",
        "PlanningCardFive",
        "PlanningCardEight",
        "PlanningCardThirteen",
        "PlanningCardTwenty",
        "PlanningCardFourty",
        "PlanningCardHundred",
        "PlanningCardQuestion",
        "PlanningCardCoffee"
    ]
}
