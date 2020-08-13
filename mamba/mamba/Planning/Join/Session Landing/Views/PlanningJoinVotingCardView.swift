//
//  PlanningJoinVotingCardView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningJoinVotingCardView: View {
    @Binding var selectedCard: PlanningCard?
    let availableCards: [PlanningCard]
    
    private var chunkedCards: [[PlanningCard]] {
        availableCards.chunked(into: 3)
    }
    
    var body: some View {
        VCardView {
            VStack(alignment: .center, spacing: 20) {
                ForEach(0 ..< self.chunkedCards.count) { index in
                    HStack(alignment: .center, spacing: 20) {
                        ForEach(self.chunkedCards[index], id: \.rawValue) { availableCard in
                            self.storyPointCard(card: availableCard)
                                .onTapGesture {
                                    self.selectedCard = availableCard
                                }
                        }
                    }
                }
            }
            .padding(leading: 20, top: 20, bottom: 20, trailing: 20)
        }
    }
    
    private func storyPointCard(card: PlanningCard) -> AnyView {
        if self.selectedCard == card {
            return AnyView(StoryPointCard(card: card)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(DefaultStyle.shared.accent, lineWidth: 4))
            )
        }
        return AnyView(StoryPointCard(card: card))
    }
}

struct PlanningJoinVotingCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlanningJoinVotingCardView(selectedCard: .constant(.one), availableCards: PlanningCard.allCases)
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
                .padding()
            
            PlanningJoinVotingCardView(selectedCard: .constant(nil), availableCards: PlanningCard.allCases)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .padding()
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
