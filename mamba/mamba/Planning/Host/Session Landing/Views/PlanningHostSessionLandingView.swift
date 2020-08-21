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
    @State private var showActionSheet = false
    @State private var showConfirmAlert = false
    @State private var actionSheetType: PlanningSessionLandingActionSheetType = .menu
    
    init(sessionName: String, availableCards: [PlanningCard]) {
        viewModel = PlanningHostSessionLandingViewModel(sessionName: sessionName, availableCards: availableCards)
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
                PlanningHostToolbarView(revoteDisabled: self.viewModel.revoteDisabled, addTicketAction: self.addTicket, revoteAction: self.revoteTicket, shareAction: self.shareActionTapped, menuAction: self.menuActionTapped)
            }
        }.actionSheet(isPresented: self.$showActionSheet) {
            self.actionSheetBuilder()
        }.alert(isPresented: self.$showConfirmAlert) {
            Alert(title: Text("PLANNING_HOST_MENU_END_SESSION_CONFIRM"), message: nil,
                  primaryButton: .cancel(),
                  secondaryButton: .destructive(Text("YES"), action: self.endSession))
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
    
    private func actionSheetBuilder() -> ActionSheet {
        switch actionSheetType {
        case .share:
            return shareActionSheet()
        case .menu:
            return actionsMenuActionSheet()
        }
    }
    
    private func actionsMenuActionSheet() -> ActionSheet {
        switch viewModel.state {
        case .voting:
            return ActionSheet(title: Text("PLANNING_ADDITIONAL_ACTION_SHEET_TITLE"), message: nil, buttons: [
                .default(Text("PLANNING_HOST_MENU_FINISH_VOTING"), action: self.finishVotingActionTapped),
                .default(Text("PLANNING_HOST_MENU_END_SESSION"), action: self.showEndSessionConfirmation),
                .cancel()
            ])
        default:
            return ActionSheet(title: Text("PLANNING_ADDITIONAL_ACTION_SHEET_TITLE"), message: nil, buttons: [
                .default(Text("PLANNING_HOST_MENU_END_SESSION"), action: self.showEndSessionConfirmation),
                .cancel()
            ])
        }
    }
    
    private func shareActionSheet() -> ActionSheet {
        ActionSheet(title: Text("PLANNING_SHARE_SESSION_SHEET_TITLE"), message: nil, buttons: [
            .default(Text("PLANNING_SHARE_SESSION_SESSION_CODE"), action: self.shareSessionCode),
            .default(Text("PLANNING_SHARE_SESSION_LINK"), action: self.shareSessionLink),
            .default(Text("PLANNING_SHARE_SESSION_QR_CODE"), action: self.shareSessionQRCode),
            .cancel()
        ])
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
            
            votingParticipantsList
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
                    .contextMenu {
                        ContextMenuButton(title: "PLANNING_HOST_PARTICIPANT_REMOVE", imageSystemName: "xmark", action: {
                            self.participantRemoveTapped(participantId: viewModel.participantId)
                        })
                }
            }
        }
        .padding(leading: 15, top: 20, bottom: 20, trailing: 15)
    }
    
    private var votingParticipantsList: some View {
        VStack(alignment: .center, spacing: 10) {
            ForEach(self.viewModel.participantList) { viewModel in
                PlanningParticipantRowView(viewModel: viewModel)
                    .contextMenu {
                        ContextMenuButton(title: "PLANNING_HOST_PARTICIPANT_SKIP_VOTE", imageSystemName: "arrowshape.turn.up.right", action: {
                            self.participantSkipVoteTapped(participantId: viewModel.participantId)
                        })
                        
                        ContextMenuButton(title: "PLANNING_HOST_PARTICIPANT_REMOVE", imageSystemName: "xmark", action: {
                            self.participantRemoveTapped(participantId: viewModel.participantId)
                        })
                    }
            }
        }
        .padding(leading: 15, top: 20, bottom: 20, trailing: 15)
    }
    
    private func addTicket() {
        Log.log(level: .info, category: .planning, message: "Host - Add ticket tapped")
        let addTicketView = PlanningAddTicketView(showSheet: $navigation.showSheet) { identifier, description in
            self.viewModel.sendAddTicketCommand(identifier: identifier, description: description)
        }
        navigation.modal(AnyView(addTicketView))
        navigation.showSheet = true
    }
    
    private func revoteTicket() {
        Log.log(level: .info, category: .planning, message: "Host - Revote ticket tapped")
        viewModel.sendRevoteTicketCommand()
    }
    
    private func showEndSessionConfirmation() {
        Log.log(level: .info, category: .planning, message: "Host - End session tapped")
        showConfirmAlert = true
    }
    
    private func finishVotingActionTapped() {
        Log.log(level: .info, category: .planning, message: "Host - Finish voting tapped")
        viewModel.sendFinishVotingCommand()
    }
    
    private func endSession() {
        Log.log(level: .info, category: .planning, message: "Host - End session confirmed")
        viewModel.sendEndSessionCommand()
    }
    
    private func shareActionTapped() {
        Log.log(level: .info, category: .planning, message: "Host - Share tapped")
        actionSheetType = .share
        showActionSheet = true
    }
    
    private func menuActionTapped() {
        Log.log(level: .info, category: .planning, message: "Host - Menu tapped")
        actionSheetType = .menu
        showActionSheet = true
    }
    
    private func participantSkipVoteTapped(participantId: String) {
        Log.log(level: .info, category: .planning, message: "Host - Skip participant vote tapped")
        viewModel.sendSkipParticipantVoteCommand(participantId: participantId)
    }
    
    private func participantRemoveTapped(participantId: String) {
        Log.log(level: .info, category: .planning, message: "Host - Remove participant tapped")
        viewModel.sendRemoveParticipantCommand(participantId: participantId)
    }
    
    private func showShareModal() {
        let shareView = PlanningHostSessionStartShareView(sessionCode: viewModel.sessionCode, showSheet: $navigation.showSheet)
        navigation.modal(AnyView(shareView))
        navigation.showSheet = true
    }
    
    private func shareSessionCode() {
        Log.log(level: .info, category: .planning, message: "Host - Share session code tapped")
        showShareSheet(shareItems: [viewModel.shareSessionCode])
    }
    
    private func shareSessionQRCode() {
        Log.log(level: .info, category: .planning, message: "Host - Share session QR code tapped")
        guard let qrCode = viewModel.shareSessionQRCode() else { return }
        showShareSheet(shareItems: [qrCode])
    }
    
    private func shareSessionLink() {
        Log.log(level: .info, category: .planning, message: "Host - Share session link tapped")
        showShareSheet(shareItems: [viewModel.shareSessionLink])
    }
    
    private func showShareSheet(shareItems: [Any]) {
        let av = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

struct PlanningHostSessionLandingView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningHostSessionLandingView(sessionName: "Planning 1", availableCards: PlanningCard.allCases)
    }
}
