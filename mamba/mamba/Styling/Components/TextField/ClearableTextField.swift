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
    
    var body: some View {
        TextField("Session name", text: self.$text)
            .textFieldStyle(ClearableTextFieldStyle())
            .modifier(ClearButton(text: self.$text))
    }
}

struct PlanningTextField_Previews: PreviewProvider {
    static var previews: some View {
        ClearableTextField(text: .constant("Test"))
    }
}
