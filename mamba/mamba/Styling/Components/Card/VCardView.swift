//
//  CardView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/29.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct VCardView<Content: View>: View {
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
        .padding(leading: 15, top: 15, trailing: 15)
    }
}

struct VCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VCardView {
                Text("Card")
                    .padding()
            }
            .environment(\.colorScheme, .light)
            .previewDisplayName("Light mode")
            .padding()
            
            VCardView {
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
