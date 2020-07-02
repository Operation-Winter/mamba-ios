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
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Button(action: {
                    self.navigation.pop()
                }) {
                    Text("Back")
                }
                Spacer()
                Button(action: {
                    self.navigation.push(AnyView(PlanningHostView()))
                }) {
                    Text("Push")
                }
                Spacer()
                Text("Planning Join View")
                    .foregroundColor(.black)
                Spacer()
            }
            Spacer()
        }.background(Color.white)
    }
}

struct PlanningJoinView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningJoinView()
    }
}
