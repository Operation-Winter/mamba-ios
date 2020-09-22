//
//  PlanningHostToolbarView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/14.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningHostToolbarView: View {
    let revoteDisabled: Bool
    let showFinishVotingAction: Bool
    let addTicketAction: () -> Void
    let revoteAction: () -> Void
    let shareSessionCodeAction: () -> Void
    let shareLinkAction: () -> Void
    let shareQrCodeAction: () -> Void
    let finishVotingAction: () -> Void
    let endSessionAction: () -> Void
    
    var body: some View {
        HStack {
            SystemImageButton(imageSystemName: "plus", action: addTicketAction)
            
            Spacer()
            
            SystemImageButton(imageSystemName: "arrow.counterclockwise", action: revoteAction)
                .disabled(revoteDisabled)
            
            Spacer()

            Menu {
                Button(action: shareQrCodeAction) {
                    Label("PLANNING_SHARE_SESSION_QR_CODE", systemImage: "qrcode")
                }
                
                Button(action: shareLinkAction) {
                    Label("PLANNING_SHARE_SESSION_LINK", systemImage: "link")
                }
                
                Button(action: shareSessionCodeAction) {
                    Label("PLANNING_SHARE_SESSION_SESSION_CODE", systemImage: "textformat.123")
                }
            }
            label: {
                Label("PLANNING_SHARE_SESSION_SHEET_TITLE", systemImage: "square.and.arrow.up")
                    .labelStyle(IconOnlyLabelStyle())
            }

            Spacer()

            Menu {
                Button(action: endSessionAction) {
                    Label("PLANNING_HOST_MENU_END_SESSION", systemImage: "xmark")
                }
                
                if showFinishVotingAction {
                    Button(action: finishVotingAction) {
                        Label("PLANNING_HOST_MENU_FINISH_VOTING", systemImage: "xmark.bin")
                    }
                }
            }
            label: {
                Label("PLANNING_ADDITIONAL_ACTION_SHEET_TITLE", systemImage: "slider.horizontal.3")
                    .labelStyle(IconOnlyLabelStyle())
            }
        }
        .padding()
        .background(
            DefaultStyle.shared.systemGray6
                .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
        )
    }
}

struct PlanningHostToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningHostToolbarView(revoteDisabled: true, showFinishVotingAction: true, addTicketAction: {}, revoteAction: {}, shareSessionCodeAction: {}, shareLinkAction: {}, shareQrCodeAction: {}, finishVotingAction: {}, endSessionAction: {})
    }
}
