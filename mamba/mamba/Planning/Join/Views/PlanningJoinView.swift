//
//  PlanningJoinView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/02.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningJoinView: View {
    @EnvironmentObject var navigation: NavigationStack
    @State private var tempName: String = ""
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("PLANNING JOIN SETUP")
                    .foregroundColor(.accentColor)
                    .font(.title)
                    .padding()
                
                ClearableTextField(text: self.$tempName, placeholder: "Join planning")
                
                Spacer()
                Button(action: {
                    self.navigation.dismiss()
                }) {
                    Text("Dismiss")
                }
                Spacer()
            }
            Spacer()
        }
    }
}

struct PlanningJoinView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningJoinView()
    }
}
