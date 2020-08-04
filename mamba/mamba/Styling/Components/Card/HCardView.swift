//
//  HCardView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct HCardView<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            content()
        }
        .background(DefaultStyle.shared.systemGray5)
        .cornerRadius(10)
        .padding(15)
    }
}

struct HCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HCardView {
                Text("Card")
                    .padding()
            }
            .environment(\.colorScheme, .light)
            .previewDisplayName("Light mode")
            .padding()
            
            HCardView {
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
