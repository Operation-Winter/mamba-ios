//
//  LandingItemView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/02.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct LandingItemView: View {
    let title: LocalizedStringKey
    let imageName: String
    
    var body: some View {
        ZStack(alignment: .top) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(30, antialiased: true)
            
            Text(title)
                .fontWeight(.medium)
                .padding(14)
                .shadow(radius: 5)
                .foregroundColor(.white)
        }
    }
}

struct LandingItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LandingItemView(title: "LANDING_RETRO_HOST", imageName: "RetroHost")
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
                .padding()

            LandingItemView(title: "LANDING_PLANNING_HOST", imageName: "PlanningHost")
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .padding()
                .background(Color.black)
            
            LandingItemView(title: "LANDING_RETRO_JOIN", imageName: "RetroJoin")
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
                .padding()

            LandingItemView(title: "LANDING_PLANNING_JOIN", imageName: "PlanningJoin")
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .padding()
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
