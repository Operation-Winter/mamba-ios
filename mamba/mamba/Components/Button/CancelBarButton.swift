//
//  CancelBarButton.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/29.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct CancelBarButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Text("CANCEL")
        }
    }
}

struct CancelBarButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CancelBarButton {}
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
                .padding()
            
            CancelBarButton {}
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .padding()
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
