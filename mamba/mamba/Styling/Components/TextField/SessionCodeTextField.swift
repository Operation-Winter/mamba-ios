//
//  SessionCodeTextField.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/03.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct SessionCodeTextField: View {
    @Binding var code1: Int?
    @Binding var code2: Int?
    @Binding var code3: Int?
    @Binding var code4: Int?
    @Binding var code5: Int?
    @Binding var code6: Int?
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            Group {
                IntegerTextField("", number: self.$code1, characterLimit: 1)
                IntegerTextField("", number: self.$code2, characterLimit: 1)
                IntegerTextField("", number: self.$code3, characterLimit: 1)
                IntegerTextField("", number: self.$code4, characterLimit: 1)
                IntegerTextField("", number: self.$code5, characterLimit: 1)
                IntegerTextField("", number: self.$code6, characterLimit: 1)
            }
                .font(.system(size: 25))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(DefaultStyle.shared.systemGray4)
                        .frame(minWidth: 38, minHeight: 45)
                )
                .multilineTextAlignment(.center)
                .frame(minWidth: 38, minHeight: 45)
        }
    }
}

struct SessionCodeTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SessionCodeTextField(code1: .constant(nil), code2: .constant(nil), code3: .constant(nil), code4: .constant(nil), code5: .constant(nil), code6: .constant(nil))
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
            SessionCodeTextField(code1: .constant(1), code2: .constant(5), code3: .constant(nil), code4: .constant(nil), code5: .constant(nil), code6: .constant(nil))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
