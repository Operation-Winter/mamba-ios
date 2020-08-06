//
//  PlanningJoinNoneStateHeaderView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningJoinNoneStateHeaderView: View {
    let title: String
    
    var body: some View {
        VCardView {
            Text(self.title)
                .font(.system(size: 20))
                .foregroundColor(.accentColor)
                .padding(leading: 20, top: 20, trailing: 20)
            
            Text("PLANNING_JOIN_LANDING_NONE_STATE_DESCRIPTION")
                .font(.system(size: 15))
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(leading: 20, top: 15, bottom: 20, trailing: 20)
                .frame(maxWidth: .infinity)
        }
    }
}

struct PlanningJoinNoneStateHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningJoinNoneStateHeaderView(title: "Planning Session")
    }
}
