//
//  CardView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/29.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct CardView<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            content()
        }
        .background(DefaultStyle.shared.systemGray5)
        .cornerRadius(10)
        .padding(15)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView {
                Text("Card")
                    .padding()
            }
            .environment(\.colorScheme, .light)
            .previewDisplayName("Light mode")
            .padding()
            
            CardView {
                Text("Card")
                    .padding()
            }
            .environment(\.colorScheme, .dark)
            .previewDisplayName("Dark mode")
            .padding()
            .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
