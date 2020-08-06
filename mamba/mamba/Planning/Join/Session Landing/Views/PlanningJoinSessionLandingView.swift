//
//  PlanningJoinSessionLandingView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningJoinSessionLandingView: View {
    @EnvironmentObject private var navigation: NavigationStack
    @ObservedObject private var viewModel: PlanningJoinSessionLandingViewModel
    
    init(sessionCode: String, participantName: String) {
        viewModel = PlanningJoinSessionLandingViewModel(sessionCode: sessionCode, participantName: participantName)
    }
    
    var body: some View {
        ScrollView {
            if self.viewModel.state == .error {
                //TODO: MAM-28
                Text("Error connecting")
            }
            
            if self.viewModel.state == .loading {
                LoadingView(title: "PLANNING_JOIN_LANDING_CONNECTING_TITLE")
                    .onAppear {
                        self.viewModel.sendJoinSessionCommand()
                    }
            }
            
            if self.viewModel.state != .loading && self.viewModel.state != .error {
                if self.viewModel.state == .none {
                    PlanningJoinNoneStateHeaderView(title: self.viewModel.sessionName)
                }
                
                VStack(alignment: .center, spacing: 10) {
                    ForEach(self.viewModel.participants) { participant in
                        PlanningParticipantRowView(participant: participant)
                    }
                }
                .padding(leading: 15, top: 5, bottom: 20, trailing: 15)
            }
        }
    }
}

struct PlanningJoinSessionLandingView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningJoinSessionLandingView(sessionCode: "000000", participantName: "Piet Pompies")
    }
}
