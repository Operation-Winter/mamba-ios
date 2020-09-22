//
//  LoadingView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    let title: LocalizedStringKey
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                ProgressView(title)
                    .progressViewStyle(CircularProgressViewStyle())
                Spacer()
            }
            Spacer()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoadingView(title: "PLANNING_HOST_LANDING_CONNECTING_TITLE")
            .environment(\.colorScheme, .light)
            .previewDisplayName("Light mode")
            .padding()
            
            LoadingView(title: "PLANNING_HOST_LANDING_CONNECTING_TITLE")
            .environment(\.colorScheme, .dark)
            .previewDisplayName("Dark mode")
            .padding()
            .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
