//
//  PlanningCard.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/29.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

public enum PlanningCard: String, CaseIterable, Codable {
    case zero = "ZERO"
    case one = "ONE"
    case two = "TWO"
    case three = "THREE"
    case five = "FIVE"
    case eight = "EIGHT"
    case thirteen = "THIRTEEN"
    case twenty = "TWENTY"
    case fourty = "FOURTY"
    case hundred = "HUNDRED"
    case question = "QUESTION"
    case coffee = "COFFEE"
    
    public var imageName: String {
        switch self {
        case .zero: return "PlanningCardZero"
        case .one: return "PlanningCardOne"
        case .two: return "PlanningCardTwo"
        case .three: return "PlanningCardThree"
        case .five: return "PlanningCardFive"
        case .eight: return "PlanningCardEight"
        case .thirteen: return "PlanningCardThirteen"
        case .twenty: return "PlanningCardTwenty"
        case .fourty: return "PlanningCardFourty"
        case .hundred: return "PlanningCardHundred"
        case .question: return "PlanningCardQuestion"
        case .coffee: return "PlanningCardCoffee"
        }
    }
    
    public var title: String {
        switch self {
        case .zero: return NSLocalizedString("PLANNING_CARD_ZERO_TITLE", comment: "0")
        case .one: return NSLocalizedString("PLANNING_CARD_ONE_TITLE", comment: "1")
        case .two: return NSLocalizedString("PLANNING_CARD_TWO_TITLE", comment: "2")
        case .three: return NSLocalizedString("PLANNING_CARD_THREE_TITLE", comment: "3")
        case .five: return NSLocalizedString("PLANNING_CARD_FIVE_TITLE", comment: "5")
        case .eight: return NSLocalizedString("PLANNING_CARD_EIGHT_TITLE", comment: "8")
        case .thirteen: return NSLocalizedString("PLANNING_CARD_THIRTEEN_TITLE", comment: "13")
        case .twenty: return NSLocalizedString("PLANNING_CARD_TWENTY_TITLE", comment: "20")
        case .fourty: return NSLocalizedString("PLANNING_CARD_FOURTY_TITLE", comment: "40")
        case .hundred: return NSLocalizedString("PLANNING_CARD_HUNDRED_TITLE", comment: "100")
        case .question: return NSLocalizedString("PLANNING_CARD_QUESTION_TITLE", comment: "?")
        case .coffee: return NSLocalizedString("PLANNING_CARD_COFFEE_TITLE", comment: "Coffee")
        }
    }
}
