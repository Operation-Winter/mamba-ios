//
//  SelectCardsButton.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/29.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct SelectCardsButton: View {
    let cardCount: String
    let action: () -> Void
    
    private var buttonTitle: String {
        let title = NSLocalizedString("PLANNING_HOST_SETUP_SELECT_CARDS_TITLE", comment: "Selected cards:")
        return String(format: title, cardCount)
    }
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            HStack {
                Spacer()
                Text(buttonTitle)
                Spacer()
                Image(systemName: "chevron.right")
                    .padding(.trailing, 3)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(11)
            .background(Color.white.opacity(0.6))
            .foregroundColor(.accentColor)
            .cornerRadius(8)
        }
    }
}

struct SelectCardsButton_Previews: PreviewProvider {
    static var previews: some View {
        SelectCardsButton(cardCount: "All") {}
    }
}
