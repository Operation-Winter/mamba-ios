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
        cancellables = cards.map { $0.objectWillChange.sink(receiveValue: { [weak self] in
            self?.objectWillChange.send() })
        }
    }
}
