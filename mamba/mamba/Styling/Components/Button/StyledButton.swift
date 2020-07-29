//
//  StyledButton.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/29.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct RoundedButton: View {
    let titleKey: LocalizedStringKey
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(titleKey)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(11)
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

struct StyledButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RoundedButton(titleKey: "PLANNING_HOST_START_SESSION_BUTTON_TITLE", action: {})
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
                .padding()
            
            RoundedButton(titleKey: "PLANNING_HOST_START_SESSION_BUTTON_TITLE", action: {})
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .padding()
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
