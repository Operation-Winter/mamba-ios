//
//  PlanningJoinToolbarView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/14.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningJoinToolbarView: View {
    let shareSessionCodeAction: () -> Void
    let shareLinkAction: () -> Void
    let shareQrCodeAction: () -> Void
    let leaveSessionAction: () -> Void
    
    var body: some View {
        HStack {
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
                Button(action: leaveSessionAction) {
                    Label("PLANNING_JOIN_MENU_LEAVE_SESSION", systemImage: "xmark")
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

struct PlanningJoinToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningJoinToolbarView(shareSessionCodeAction: {}, shareLinkAction: {}, shareQrCodeAction: {}, leaveSessionAction: {})
    }
}
