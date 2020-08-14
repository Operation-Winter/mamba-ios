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
        VStack {
            ScrollView {
                stateViewBuilder()
            }
            
            if !self.viewModel.toolBarHidden {
                PlanningHostToolbarView(revoteDisabled: self.viewModel.revoteDisabled, addTicketAction: self.addTicket, revoteAction: self.revoteTicket, shareAction: self.shareSession, menuAction: {})
            }
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
        LoadingView(title: "PLANNING_HOST_LANDING_CONNECTING_TITLE")
            .onAppear {
                self.viewModel.sendStartSessionCommand()
        }
    }
    
    private var noneStateView: some View {
        Group {
            PlanningHostNoneStateCardView(title: self.viewModel.sessionName) {
                self.addTicket()
            }
            .onReceive(self.viewModel.$showInitialShareModal, perform: { shouldShow in
                if shouldShow {
                    self.showShareModal()
                }
            })
            
            participantsList
        }
    }
    
    private var votingStateView: some View {
        Group {
            PlanningVotingStateTicketCardView(title: self.viewModel.sessionName,
                                              ticketIdentifier: self.viewModel.ticket?.identifier,
                                              ticketDescription: self.viewModel.ticket?.description)
            
            participantsList
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
    
    private func addTicket() {
        let addTicketView = PlanningAddTicketView(showSheet: $navigation.showSheet) { identifier, description in
            self.viewModel.sendAddTicketCommand(identifier: identifier, description: description)
        }
        navigation.modal(AnyView(addTicketView))
        navigation.showSheet = true
    }
    
    private func revoteTicket() {
        viewModel.sendRevoteTicketCommand()
    }
    
    private func shareSession() {
        
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
