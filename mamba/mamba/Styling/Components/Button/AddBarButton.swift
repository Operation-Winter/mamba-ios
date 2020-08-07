//
//  AddBarButton.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct AddBarButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Text("ADD")
        }
    }
}

struct AddBarButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddBarButton {}
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
                .padding()
            
            AddBarButton {}
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .padding()
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
