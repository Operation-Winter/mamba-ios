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
            stateViewBuilder()
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
            return AnyView(EmptyView())
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
            
            participantsList
        }
    }

    private var participantsList: some View {
        VStack(alignment: .center, spacing: 10) {
            ForEach(self.viewModel.participants) { participant in
                PlanningParticipantRowView(participant: participant)
            }
        }
        .padding(leading: 15, top: 20, bottom: 20, trailing: 15)
    }
}

struct PlanningJoinSessionLandingView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningJoinSessionLandingView(sessionCode: "000000", participantName: "Piet Pompies")
    }
}
