//
//  PlanningHostAvailableCardsView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/30.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class PlanningHostAvailableCardsViewModel: ObservableObject {
    private(set) var cards: [AvailableCard]
    private(set) var chunkedCards: [[AvailableCard]]
    private var cancellables = [AnyCancellable]()

    init(availableCards: [AvailableCard]) {
        cards = availableCards
        chunkedCards = cards.chunked(into: 3)
        
        cards.forEach {
            let cardObservable = $0.objectWillChange.sink(receiveValue: { self.objectWillChange.send() })
            cancellables.append(cardObservable)
        }
    }
}

class AvailableCard: Identifiable, ObservableObject {
    let card: PlanningCard
    @Published var selected: Bool
    
    init(card: PlanningCard, selected: Bool) {
        self.card = card
        self.selected = selected
    }
}
