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
    @Published var availableCards = PlanningCard.allCases.map { AvailableCard(card: $0, selected: true) }
    private var cancellables = [AnyCancellable]()
    
    init() {
        availableCards.forEach {
            let cardObservable = $0.objectWillChange.sink(receiveValue: { self.objectWillChange.send() })
            cancellables.append(cardObservable)
        }
    }
    
    private var selectedCardCount: Int {
        availableCards.filter({ $0.selected }).count
    }
    
    var selectedCardsCountTitle: String {
        if selectedCardCount == availableCards.count {
            return NSLocalizedString("ALL", comment: "All")
        }
        if selectedCardCount <= availableCards.count && selectedCardCount > 0 {
            return "\(selectedCardCount)"
        }
        return NSLocalizedString("NONE", comment: "None")
    }
}
