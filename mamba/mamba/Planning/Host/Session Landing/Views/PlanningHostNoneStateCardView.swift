//
//  PlanningHostNoneStateCardView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningHostNoneStateCardView: View {
    let title: String
    let buttonAction: () -> Void
    
    var body: some View {
        VCardView {
            Text(title)
                .font(.system(size: 20))
                .foregroundColor(.accentColor)
                .padding(leading: 20, top: 20, trailing: 20)
            
            Text("PLANNING_HOST_LANDING_NONE_STATE_DESCRIPTION")
                .font(.system(size: 15))
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(leading: 20, top: 15, trailing: 20)
            
            RoundedButton(titleKey: "PLANNING_HOST_LANDING_ADD_TICKET_BUTTON_TITLE") {
                buttonAction()
            }
            .padding(leading: 20, top: 20, bottom: 20, trailing: 20)
        }
    }
}

struct PlanningHostNoneStateCardView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningHostNoneStateCardView(title: "Planning 1", buttonAction: {})
    }
}
