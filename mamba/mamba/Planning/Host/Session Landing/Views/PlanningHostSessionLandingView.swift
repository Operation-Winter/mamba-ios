//
//  PlanningHostSessionLandingView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningHostSessionLandingView: View {
    @EnvironmentObject private var navigation: NavigationStack
    @ObservedObject private var viewModel = PlanningHostSessionLandingViewModel()
    
    var body: some View {
        // TODO: Loading indicator when page loads
        ScrollView {
            CardView {
                Text(self.viewModel.title)
                    .font(.system(size: 20))
                    .foregroundColor(.accentColor)
                    .padding(leading: 20, top: 20, trailing: 20)
                
                Text("PLANNING_HOST_LANDING_NONE_STATE_DESCRIPTION")
                    .font(.system(size: 15))
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .padding(leading: 20, top: 15, trailing: 20)
                
                RoundedButton(titleKey: "PLANNING_HOST_LANDING_ADD_TICKET_BUTTON_TITLE") {
                    self.addTicket()
                }
                .padding(leading: 20, top: 20, bottom: 20, trailing: 20)
            }
        }
    }
    
    private func addTicket() {
        //TODO: MAM-31
    }
    
    private func showError() {
        //TODO: MAM-28
    }
}

struct PlanningHostSessionLandingView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningHostSessionLandingView()
    }
}
