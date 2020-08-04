//
//  PlanningCard.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/29.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

enum PlanningCard: String, CaseIterable, Codable {
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
    
    var imageName: String {
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
}
