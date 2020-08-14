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
    @State private var showActionsMenu = false
    @State private var showConfirmAlert = false
    
    init(sessionCode: String, participantName: String) {
        viewModel = PlanningJoinSessionLandingViewModel(sessionCode: sessionCode, participantName: participantName)
    }
    
    var body: some View {
        if viewModel.dismiss {
            self.navigation.dismiss()
        }
        
        return VStack(alignment: .center, spacing: 0) {
            ScrollView {
                stateViewBuilder()
            }
            
            if !self.viewModel.toolBarHidden {
                PlanningJoinToolbarView(shareAction: {
                    // TODO: MAM-68
                }, menuAction: self.menuActionTapped)
            }
        }.actionSheet(isPresented: self.$showActionsMenu) {
            ActionSheet(title: Text("PLANNING_ADDITIONAL_ACTION_SHEET_TITLE"), message: nil, buttons: [
                .default(Text("PLANNING_JOIN_MENU_LEAVE_SESSION"), action: self.showLeaveSessionConfirmation),
                .cancel()
            ])
        }.alert(isPresented: self.$showConfirmAlert) {
            Alert(title: Text("PLANNING_JOIN_MENU_LEAVE_SESSION_CONFIRM"), message: nil,
                  primaryButton: .cancel(),
                  secondaryButton: .default(Text("YES"), action: self.leaveSession))
        }
    }
    
    private func stateViewBuilder() -> AnyView {
        switch viewModel.state {
        case .error(let planningError):
            return AnyView(errorCard(planningError: planningError))
        case .loading:
            return AnyView(loadingView)
        case .none:
            return AnyView(noneStateView)
        case .voting:
            return AnyView(votingStateView)
        case .finishedVoting:
            return AnyView(votingFinishedStateView)
        }
    }
    
    private func errorCard(planningError: PlanningLandingError) -> some View {
        PlanningErrorCardView(error: PlanningLandingError(code: planningError.code, description: planningError.description), buttonTitle: "PLANNING_ERROR_BUTTON_BACK_TO_LANDING_TITLE") {
            self.navigation.dismiss()
        }
    }
    
    private var loadingView: some View {
        LoadingView(title: "PLANNING_JOIN_LANDING_CONNECTING_TITLE")
            .onAppear {
                self.viewModel.sendJoinSessionCommand()
            }
    }
    
    private var noneStateView: some View {
        Group {
            PlanningJoinNoneStateHeaderView(title: self.viewModel.sessionName)
            participantsList
        }
    }
    
    private var votingStateView: some View {
        Group {
            PlanningVotingStateTicketCardView(title: self.viewModel.sessionName,
                                              ticketIdentifier: self.viewModel.ticket?.identifier,
                                              ticketDescription: self.viewModel.ticket?.description)
            
            PlanningJoinVotingCardView(selectedCard: self.$viewModel.selectedCard, availableCards: self.viewModel.availableCards)
                .padding(.bottom, 20)
        }
    }
    
    private var votingFinishedStateView: some View {
        Group {
            PlanningVotingStateTicketCardView(title: self.viewModel.sessionName,
                                              ticketIdentifier: self.viewModel.ticket?.identifier,
                                              ticketDescription: self.viewModel.ticket?.description)
            
            PlanningFinishedVotingStateGraphCardView(barGraphEntries: self.viewModel.barGraphEntries)
                .padding(.top, 10)
            
            participantsList
        }
    }

    private var participantsList: some View {
        VStack(alignment: .center, spacing: 10) {
            ForEach(self.viewModel.participantList) { viewModel in
                PlanningParticipantRowView(viewModel: viewModel)
            }
        }
        .padding(leading: 15, top: 20, bottom: 20, trailing: 15)
    }
    
    private func menuActionTapped() {
        Log.log(level: .info, category: .planning, message: "Join - Menu tapped")
        showActionsMenu = true
    }
    
    private func showLeaveSessionConfirmation() {
        Log.log(level: .info, category: .planning, message: "Join - Leave session tapped")
        showConfirmAlert = true
    }
    
    private func leaveSession() {
        Log.log(level: .info, category: .planning, message: "Join - Leave session confirmed")
        viewModel.sendLeaveSessionCommand()
    }
}

struct PlanningJoinSessionLandingView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningJoinSessionLandingView(sessionCode: "000000", participantName: "Piet Pompies")
    }
}
