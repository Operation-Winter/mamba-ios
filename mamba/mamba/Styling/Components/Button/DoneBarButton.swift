//
//  DoneBarButton.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct DoneBarButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Text("DONE")
        }
    }
}

struct DoneBarButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DoneBarButton {}
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
                .padding()
            
            DoneBarButton {}
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .padding()
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
