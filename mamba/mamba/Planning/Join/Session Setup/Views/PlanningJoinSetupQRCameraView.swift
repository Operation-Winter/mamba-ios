//
//  PlanningJoinSetupQRCameraView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/21.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningJoinSetupQRCameraView: View {
    @Binding var sessionCode: String?
    @Binding var showQrCode: Bool
    
    var body: some View {
        QrScannerView { qrCodeURL in
            guard let sessionCode = URLCenter.shared.planningSessionCode(from: qrCodeURL) else { return }
            self.sessionCode = sessionCode
            self.showQrCode = false
        }
        .navigationBarTitle("PLANNING_JOIN_SETUP_QR_VIEW_TITLE", displayMode: .inline)
    }
}

struct PlanningJoinSetupQRCameraView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningJoinSetupQRCameraView(sessionCode: .constant("000000"), showQrCode: .constant(true))
    }
}
