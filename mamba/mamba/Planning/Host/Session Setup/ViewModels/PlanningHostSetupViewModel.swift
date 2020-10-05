//
//  PlanningHostSetupViewModel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine
import MambaNetworking

class PlanningHostSetupViewModel: ObservableObject {
    @Published var sessionName: String = ""
    @Published var availableCards = PlanningCard.allCases.map { AvailableCard(card: $0, selected: true) }
    
    private var cancellables = [AnyCancellable]()
    
    private var selectedCardCount: Int {
        availableCards.filter({ $0.selected }).count
    }
    
    var inputValid: Bool {
        !sessionName.isEmpty && selectedCardCount > 0
    }
    
    var selectedCardsCountTitle: String {
        if selectedCardCount == availableCards.count {
            return NSLocalizedString("ALL", comment: "All")
        }
        if selectedCardCount <= availableCards.count && selectedCardCount > 0 {
            return NSLocalizedString("SOME", comment: "Some")
        }
        return NSLocalizedString("NONE", comment: "None")
    }
    
    init() {
        cancellables = availableCards.map { $0.objectWillChange.sink(receiveValue: { [weak self] in
            self?.objectWillChange.send() })
        }
    }
}
