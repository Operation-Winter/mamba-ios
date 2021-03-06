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
    let systemImage: String?
    let action: () -> Void
    
    init(titleKey: LocalizedStringKey, systemImage: String? = nil, action: @escaping () -> Void) {
        self.titleKey = titleKey
        self.systemImage = systemImage
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                if self.systemImage != nil {
                    Image(systemName: self.systemImage!)
                }
                Text(titleKey)
            }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(11)
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

struct RoundedButton_Previews: PreviewProvider {
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
            
            RoundedButton(titleKey: "PLANNING_HOST_START_SESSION_BUTTON_TITLE", systemImage: "square.and.arrow.up", action: {})
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
                .padding()
            
            RoundedButton(titleKey: "PLANNING_HOST_START_SESSION_BUTTON_TITLE", systemImage: "square.and.arrow.up", action: {})
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .padding()
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
