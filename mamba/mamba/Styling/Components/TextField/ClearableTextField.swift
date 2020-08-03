//
//  ClearableTextField.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct ClearableTextField: View {
    @Binding var text: String
    var placeholder: LocalizedStringKey
    
    var body: some View {
        // TODO: Convert to UIKit UITextField to allow for Keyboard firstResponder
        TextField(placeholder, text: self.$text)
            .textFieldStyle(ClearableTextFieldStyle())
            .modifier(ClearButton(text: self.$text))
    }
}

struct PlanningTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ClearableTextField(text: .constant("Test"), placeholder: "PLANNING_HOST_START_SESSION_NAME_PLACEHOLDER")
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
                .padding()
            
            ClearableTextField(text: .constant("Test"), placeholder: "PLANNING_HOST_START_SESSION_NAME_PLACEHOLDER")
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .padding()
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
