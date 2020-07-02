//
//  PlanningHostView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/02.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningHostView: View {
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
                    self.navigation.push(AnyView(PlanningJoinView()))
                }) {
                    Text("Push")
                }
                Spacer()
                Text("Planning Host View")
                    .foregroundColor(.black)
                Spacer()
            }
            Spacer()
        }.background(Color.white)
    }
}

struct PlanningHostView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningHostView()
    }
}
