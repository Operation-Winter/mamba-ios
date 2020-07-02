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
        VStack {
            Button(action: {
                self.navigation.unwind()
            }) {
                Text("Back")
            }
            Text("Planning Host View")
        }
    }
}

struct PlanningHostView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningHostView()
    }
}
