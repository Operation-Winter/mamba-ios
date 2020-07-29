//
//  PlanningHostSetupViewModel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine

class PlanningHostSetupViewModel: ObservableObject {
    @Published var sessionName: String = ""
    @Published var selectedCards = PlanningCard.allCases
    
    var selectedCardsCountTitle: String {
        if selectedCards.count == PlanningCard.allCases.count {
            return NSLocalizedString("ALL", comment: "All")
        }
        if selectedCards.count <= PlanningCard.allCases.count && selectedCards.count > 0 {
            return "\(selectedCards.count)"
        }
        return NSLocalizedString("NONE", comment: "None")
    }
}
