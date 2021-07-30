//
//  CodeText.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct CodeText: View {
    let value: String
    
    var body: some View {
        Text(value)
            .font(.system(size: 25))
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(DefaultStyle.shared.systemGray4)
                    .frame(minWidth: 38, minHeight: 45)
            )
            .frame(minWidth: 38, minHeight: 45)
    }
}

struct CodeText_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CodeText(value: "0")
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
            CodeText(value: "1")
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
