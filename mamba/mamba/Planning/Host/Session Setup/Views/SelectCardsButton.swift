//
//  SelectCardsButton.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/29.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct SelectCardsButton<Content: View>: View {
    let cardCount: String
    let destination: Content
    
    private var buttonTitle: String {
        let title = NSLocalizedString("PLANNING_HOST_SETUP_SELECT_CARDS_TITLE", comment: "Selected cards:")
        return String(format: title, cardCount)
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Spacer()
                Text(buttonTitle)
                Spacer()
                Image(systemName: "chevron.right")
                    .padding(.trailing, 3)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(11)
            .background(DefaultStyle.shared.systemGray4)
            .foregroundColor(.accentColor)
            .cornerRadius(8)
        }
    }
}

struct SelectCardsButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SelectCardsButton(cardCount: "All", destination: EmptyView())
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
                .padding()
            
            SelectCardsButton(cardCount: "All", destination: EmptyView())
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .padding()
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
