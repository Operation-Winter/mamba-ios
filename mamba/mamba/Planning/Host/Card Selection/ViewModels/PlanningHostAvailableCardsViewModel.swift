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
    private var cancellables = [AnyCancellable]()

    private(set) var gridItems: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(availableCards: [AvailableCard]) {
        cards = availableCards
        cancellables = cards.map { $0.objectWillChange.sink(receiveValue: { [weak self] in
            self?.objectWillChange.send() })
        }
    }
}
