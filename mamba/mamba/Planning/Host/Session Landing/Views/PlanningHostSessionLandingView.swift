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
    @StateObject private var viewModel: PlanningHostSessionLandingViewModel
    @State private var showConfirmAlert = false
    
    init(sessionName: String, availableCards: [PlanningCard]) {
        _viewModel = StateObject(wrappedValue: PlanningHostSessionLandingViewModel(sessionName: sessionName, availableCards: availableCards))
    }
    
    var body: some View {
        if viewModel.dismiss {
            navigation.dismiss()
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
                PlanningHostToolbarView(revoteDisabled: viewModel.revoteDisabled,
                                        showFinishVotingAction: viewModel.finishVotingVisible,
                                        addTicketAction: addTicket,
                                        revoteAction: revoteTicket,
                                        shareSessionCodeAction: shareSessionCode,
                                        shareLinkAction: shareSessionLink,
                                        shareQrCodeAction: shareSessionQRCode,
                                        finishVotingAction: finishVotingActionTapped,
                                        endSessionAction: showEndSessionConfirmation)
            }
        }
        .alert(isPresented: $showConfirmAlert) {
            Alert(title: Text("PLANNING_HOST_MENU_END_SESSION_CONFIRM"), message: nil,
                  primaryButton: .cancel(),
                  secondaryButton: .destructive(Text("YES"), action: self.endSession))
        }
    }
    
    private func errorCard(planningError: PlanningLandingError) -> some View {
        PlanningErrorCardView(error: PlanningLandingError(code: planningError.code, description: planningError.description), buttonTitle: "PLANNING_ERROR_BUTTON_BACK_TO_LANDING_TITLE") {
            navigation.dismiss()
        }
    }
    
    private var loadingView: some View {
        LoadingView(title: "PLANNING_HOST_LANDING_CONNECTING_TITLE")
            .onAppear {
                viewModel.sendStartSessionCommand()
            }
    }
    
    private var noneStateView: some View {
        Group {
            PlanningHostNoneStateCardView(title: viewModel.sessionName) {
                addTicket()
            }
            .onReceive(viewModel.$showInitialShareModal, perform: { shouldShow in
                if shouldShow {
                    showShareModal()
                }
            })
            
            participantsList
        }
    }
    
    private var votingStateView: some View {
        Group {
            PlanningVotingStateTicketCardView(title: viewModel.sessionName,
                                              ticketIdentifier: viewModel.ticket?.identifier,
                                              ticketDescription: viewModel.ticket?.description)
            
            votingParticipantsList
        }
    }
    
    private var votingFinishedStateView: some View {
        Group {
            PlanningVotingStateTicketCardView(title: viewModel.sessionName,
                                              ticketIdentifier: viewModel.ticket?.identifier,
                                              ticketDescription: viewModel.ticket?.description)
            
            PlanningFinishedVotingStateGraphCardView(barGraphEntries: viewModel.barGraphEntries)
                .padding(.top, 10)
            
            participantsList
        }
    }
    
    private var participantsList: some View {
        LazyVGrid(columns: viewModel.gridItems, alignment: .center, spacing: 10) {
            ForEach(viewModel.participantList) { viewModel in
                PlanningParticipantRowView(viewModel: viewModel)
                    .contextMenu {
                        ContextMenuButton(title: "PLANNING_HOST_PARTICIPANT_REMOVE", imageSystemName: "xmark", action: {
                            participantRemoveTapped(participantId: viewModel.participantId)
                        })
                    }
            }
        }
        .padding(leading: 15, top: 20, bottom: 20, trailing: 15)
    }
    
    private var votingParticipantsList: some View {
        LazyVGrid(columns: viewModel.gridItems, alignment: .center, spacing: 10) {
            ForEach(viewModel.participantList) { viewModel in
                PlanningParticipantRowView(viewModel: viewModel)
                    .contextMenu {
                        ContextMenuButton(title: "PLANNING_HOST_PARTICIPANT_SKIP_VOTE", imageSystemName: "arrowshape.turn.up.right", action: {
                            participantSkipVoteTapped(participantId: viewModel.participantId)
                        })
                        
                        ContextMenuButton(title: "PLANNING_HOST_PARTICIPANT_REMOVE", imageSystemName: "xmark", action: {
                            participantRemoveTapped(participantId: viewModel.participantId)
                        })
                    }
            }
        }
        .padding(leading: 15, top: 20, bottom: 20, trailing: 15)
    }
    
    private func addTicket() {
        Log.planning.logger.info("Host - Add ticket tapped")
        let addTicketView = PlanningAddTicketView(showSheet: $navigation.showSheet) { identifier, description in
            self.viewModel.sendAddTicketCommand(identifier: identifier, description: description)
        }
        navigation.modal(AnyView(addTicketView))
        navigation.showSheet = true
    }
    
    private func revoteTicket() {
        Log.planning.logger.info("Host - Revote ticket tapped")
        viewModel.sendRevoteTicketCommand()
    }
    
    private func showEndSessionConfirmation() {
        Log.planning.logger.info("Host - End session tapped")
        showConfirmAlert = true
    }
    
    private func finishVotingActionTapped() {
        Log.planning.logger.info("Host - Finish voting tapped")
        viewModel.sendFinishVotingCommand()
    }
    
    private func endSession() {
        Log.planning.logger.info("Host - End session confirmed")
        viewModel.sendEndSessionCommand()
    }
    
    private func participantSkipVoteTapped(participantId: String) {
        Log.planning.logger.info("Host - Skip participant vote tapped")
        viewModel.sendSkipParticipantVoteCommand(participantId: participantId)
    }
    
    private func participantRemoveTapped(participantId: String) {
        Log.planning.logger.info("Host - Remove participant tapped")
        viewModel.sendRemoveParticipantCommand(participantId: participantId)
    }
    
    private func showShareModal() {
        let shareView = PlanningHostSessionStartShareView(sessionCode: viewModel.sessionCode, showSheet: $navigation.showSheet)
        navigation.modal(AnyView(shareView))
        navigation.showSheet = true
    }
    
    private func shareSessionCode() {
        Log.planning.logger.info("Host - Share session code tapped")
        let shareSheet = ShareSheet(activityItems: [viewModel.shareSessionCode]).edgesIgnoringSafeArea(.all)
        navigation.modal(AnyView(shareSheet))
        navigation.showSheet = true
    }
    
    private func shareSessionQRCode() {
        Log.planning.logger.info("Host - Share session QR code tapped")
        guard let qrCode = viewModel.shareSessionQRCode() else { return }
        let shareSheet = ShareSheet(activityItems: [qrCode]).edgesIgnoringSafeArea(.all)
        navigation.modal(AnyView(shareSheet))
        navigation.showSheet = true
    }
    
    private func shareSessionLink() {
        Log.planning.logger.info("Host - Share session link tapped")
        let shareSheet = ShareSheet(activityItems: [viewModel.shareSessionLink]).edgesIgnoringSafeArea(.all)
        navigation.modal(AnyView(shareSheet))
        navigation.showSheet = true
    }
}

struct PlanningHostSessionLandingView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningHostSessionLandingView(sessionName: "Planning 1", availableCards: PlanningCard.allCases)
    }
}
