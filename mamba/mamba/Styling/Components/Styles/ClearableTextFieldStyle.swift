//
//  ClearableTextFieldStyle.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct ClearableTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack() {
            configuration
                .padding(12)
                .background(Rectangle()
                    .fill(Color.gray.opacity(0.2)))
                .cornerRadius(15)
        }
    }
}

struct PlanningTextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextField("Test", text: .constant(""))
                .textFieldStyle(ClearableTextFieldStyle())
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
                .padding()
            
            TextField("Test", text: .constant(""))
                .textFieldStyle(ClearableTextFieldStyle())
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .padding()
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
