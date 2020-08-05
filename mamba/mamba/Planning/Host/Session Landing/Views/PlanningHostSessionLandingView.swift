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
                Text("Error connecting")
            }
            
            if self.viewModel.state == .loading {
                LoadingView(title: "PLANNING_HOST_LANDING_CONNECTING_TITLE")
                    .onAppear {
                        self.viewModel.startSession()
                    }
            }
            
            if self.viewModel.state != .loading && self.viewModel.state != .error {
                if self.viewModel.state == .none {
                    PlanningHostNoneStateCardView(title: self.viewModel.sessionName) {
                        self.addTicket()
                    }
                    .onReceive(self.viewModel.$showInitialShareModal, perform: { shouldShow in
                        if shouldShow {
                            self.showShareModal()
                        }
                    })
                }
                
                ForEach(self.viewModel.participants) { participant in
                    PlanningParticipantRowView(participant: participant)
                }
            }
        }
    }
    
    private func addTicket() {
        //TODO: MAM-31
    }
    
    private func showShareModal() {
        let shareView = PlanningHostSessionStartShareView(sessionCode: viewModel.sessionCode, showSheet: $navigation.showSheet)
        navigation.modal(AnyView(shareView))
        navigation.showSheet = true
    }
}

struct PlanningHostSessionLandingView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningHostSessionLandingView(sessionName: "Planning 1", availableCards: PlanningCard.allCases)
    }
}
