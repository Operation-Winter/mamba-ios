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
    @StateObject private var viewModel: PlanningJoinSessionLandingViewModel
    @State private var showConfirmAlert = false
    
    init(sessionCode: String, participantName: String) {
        _viewModel = StateObject(wrappedValue: PlanningJoinSessionLandingViewModel(sessionCode: sessionCode, participantName: participantName))
    }
    
    var body: some View {
        if viewModel.dismiss {
            self.navigation.dismiss()
        }
        
        return VStack(alignment: .center, spacing: 0) {
            ScrollView {
                switch viewModel.state {
                case .error(let planningError):
                    errorCard(planningError: planningError)
                case .loading:
                    loadingView
                case .none:
                    noneStateView
                case .voting:
                    votingStateView
                case .finishedVoting:
                    votingFinishedStateView
                }
            }
            
            if !self.viewModel.toolBarHidden {
                PlanningJoinToolbarView(shareSessionCodeAction: shareSessionCode, shareLinkAction: shareSessionLink, shareQrCodeAction: shareSessionQRCode, leaveSessionAction: showLeaveSessionConfirmation)
            }
        }.alert(isPresented: $showConfirmAlert) {
            Alert(title: Text("PLANNING_JOIN_MENU_LEAVE_SESSION_CONFIRM"), message: nil,
                  primaryButton: .cancel(),
                  secondaryButton: .destructive(Text("YES"), action: leaveSession))
        }
    }

    private func errorCard(planningError: PlanningLandingError) -> some View {
        PlanningErrorCardView(error: PlanningLandingError(code: planningError.code, description: planningError.description), buttonTitle: "PLANNING_ERROR_BUTTON_BACK_TO_LANDING_TITLE") {
            self.navigation.dismiss()
        }
    }
    
    private var loadingView: some View {
        LoadingView(title: "PLANNING_JOIN_LANDING_CONNECTING_TITLE")
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
                                              ticketIdentifier: self.viewModel.ticket?.title,
                                              ticketDescription: self.viewModel.ticket?.description)
            
            PlanningJoinVotingCardView(selectedCard: self.$viewModel.selectedCard, availableCards: self.viewModel.availableCards)
                .padding(.bottom, 20)
        }
    }
    
    private var votingFinishedStateView: some View {
        Group {
            PlanningVotingStateTicketCardView(title: self.viewModel.sessionName,
                                              ticketIdentifier: self.viewModel.ticket?.title,
                                              ticketDescription: self.viewModel.ticket?.description)
            
            PlanningFinishedVotingStateGraphCardView(barGraphEntries: self.viewModel.barGraphEntries)
                .padding(.top, 10)
            
            participantsList
        }
    }

    private var participantsList: some View {
        LazyVGrid(columns: viewModel.gridItems, alignment: .center, spacing: 10) {
            ForEach(self.viewModel.participantList) { viewModel in
                PlanningParticipantRowView(viewModel: viewModel)
            }
        }
        .padding(leading: 15, top: 20, bottom: 20, trailing: 15)
    }
    
    private func showLeaveSessionConfirmation() {
        Log.planning.logger.info("Join - Leave session tapped")
        showConfirmAlert = true
    }
    
    private func leaveSession() {
        Log.planning.logger.info("Join - Leave session confirmed")
        viewModel.sendLeaveSessionCommand()
    }
    
    private func shareSessionCode() {
        Log.planning.logger.info("Join - Share session code tapped")
        let shareSheet = ShareSheet(activityItems: [viewModel.shareSessionCode]).edgesIgnoringSafeArea(.all)
        navigation.modal(AnyView(shareSheet))
        navigation.showSheet = true
    }
    
    private func shareSessionQRCode() {
        Log.planning.logger.info("Join - Share session QR code tapped")
        guard let qrCode = viewModel.shareSessionQRCode() else { return }
        let shareSheet = ShareSheet(activityItems: [qrCode]).edgesIgnoringSafeArea(.all)
        navigation.modal(AnyView(shareSheet))
        navigation.showSheet = true
    }
    
    private func shareSessionLink() {
        Log.planning.logger.info("Join - Share session link tapped")
        let shareSheet = ShareSheet(activityItems: [viewModel.shareSessionLink]).edgesIgnoringSafeArea(.all)
        navigation.modal(AnyView(shareSheet))
        navigation.showSheet = true
    }
}

struct PlanningJoinSessionLandingView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningJoinSessionLandingView(sessionCode: "000000", participantName: "Piet Pompies")
    }
}
