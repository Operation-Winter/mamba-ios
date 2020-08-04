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
    @ObservedObject private var viewModel: PlanningHostSessionLandingViewModel
    
    init(sessionName: String, availableCards: [PlanningCard]) {
        viewModel = PlanningHostSessionLandingViewModel(sessionName: sessionName, availableCards: availableCards)
    }
    
    var body: some View {
        ScrollView {
            if self.viewModel.state == .error {
                //TODO: MAM-28
            }
            
            if self.viewModel.state == .loading {
                LoadingView(title: "PLANNING_HOST_LANDING_CONNECTING_TITLE")
            }
            
            if self.viewModel.state != .loading {
                if self.viewModel.state == .none {
                    PlanningHostNoneStateCardView(title: self.viewModel.sessionName) {
                        self.addTicket()
                    }
                }
                
                ForEach(self.viewModel.participants) { participant in
                    PlanningHostParticipantRowView(participant: participant)
                }
            }
        }.onAppear{
            self.viewModel.startSession()
        }
    }
    
    private func addTicket() {
        //TODO: MAM-31
    }
}

struct PlanningHostSessionLandingView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningHostSessionLandingView(sessionName: "Planning 1", availableCards: PlanningCard.allCases)
    }
}
