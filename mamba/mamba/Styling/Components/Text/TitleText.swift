//
//  TitleText.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/29.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct TitleText: View {
    let titleKey: LocalizedStringKey
    
    var body: some View {
        Text(titleKey)
            .foregroundColor(.accentColor)
            .font(.system(size: 20))
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TitleText(titleKey: "PLANNING_HOST_SETUP_TITLE")
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
                .padding()
            
            TitleText(titleKey: "PLANNING_HOST_SETUP_TITLE")
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .padding()
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
