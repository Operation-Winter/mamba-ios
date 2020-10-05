//
//  PlanningHostAvailableCardsView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/30.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI
import MambaNetworking

struct PlanningHostAvailableCardsView: View {
    @StateObject private var viewModel: PlanningHostAvailableCardsViewModel
    
    init(availableCards: [AvailableCard]) {
        _viewModel = StateObject(wrappedValue: PlanningHostAvailableCardsViewModel(availableCards: availableCards))
    }
    
    var body: some View {
        ScrollView {
            VCardView {
                LazyVGrid(columns: viewModel.gridItems) {
                    ForEach(viewModel.cards) { availableCard in
                        ZStack(alignment: .topTrailing) {
                            StoryPointCard(card: availableCard.card)
                            
                            Image(systemName: systemImageName(selected: availableCard.selected))
                                .padding(top: 10, trailing: 10)
                                .foregroundColor(DefaultStyle.shared.qauternary)
                        }.onTapGesture {
                            availableCard.selected.toggle()
                        }
                    }
                }
                .padding(leading: 20, top: 20, bottom: 20, trailing: 20)
            }
        }
        .navigationBarTitle("PLANNING_HOST_SETUP_SELECT_CARDS_MODAL_TITLE", displayMode: .inline)
    }
    
    private func systemImageName(selected: Bool) -> String {
        selected
            ? "checkmark.circle.fill"
            : "circle"
    }
}

struct PlanningHostAvailableCardsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlanningHostAvailableCardsView(availableCards: PlanningCard.allCases.map { AvailableCard(card: $0, selected: true) })
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
            
            PlanningHostAvailableCardsView(availableCards: PlanningCard.allCases.map { AvailableCard(card: $0, selected: false) })
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .background(Color.black)
        }
    }
}
