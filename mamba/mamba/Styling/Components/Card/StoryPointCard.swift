//
//  StoryPointCard.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/30.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct StoryPointCard: View {
    let card: PlanningCard
 
    var body: some View {
        Image(self.card.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct StoryPointCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                StoryPointCard(card: .zero)
                StoryPointCard(card: .one)
                StoryPointCard(card: .two)
                StoryPointCard(card: .three)
                StoryPointCard(card: .five)
                StoryPointCard(card: .eight)
                StoryPointCard(card: .thirteen)
                StoryPointCard(card: .twenty)
                StoryPointCard(card: .fourty)
                StoryPointCard(card: .hundred)
            }
            Group {
                StoryPointCard(card: .question)
                StoryPointCard(card: .coffee)
            }
        }.previewLayout(.sizeThatFits)
    }
}
