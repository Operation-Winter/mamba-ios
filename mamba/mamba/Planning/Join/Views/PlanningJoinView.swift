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
        VStack {
            Button(action: {
                self.navigation.unwind()
            }) {
                Text("Back")
            }
            Text("Planning Join View")
        }
    }
}

struct PlanningJoinView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningJoinView()
    }
}
