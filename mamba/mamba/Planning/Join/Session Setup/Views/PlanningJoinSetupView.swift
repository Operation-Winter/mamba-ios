//
//  PlanningJoinSetupView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/02.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningJoinSetupView: View {
    @EnvironmentObject private var navigation: NavigationStack
    @StateObject private var viewModel = PlanningJoinSetupViewModel()
    @State private var showQrCode: Bool = false
    @Binding var showSheet: Bool

    func configure(sessionCode: String) {
        viewModel.sessionCode = sessionCode
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VCardView {
                    TitleText(titleKey: "PLANNING_JOIN_SETUP_TITLE")
                        .padding(leading: 20, top: 20, trailing: 20)
                    
                    ClearableTextField(text: $viewModel.participantName,
                                       placeholder: "PLANNING_JOIN_SETUP_NAME_PLACEHOLDER")
                        .padding(leading: 20, top: 10, trailing: 20)
                    
                    Text("PLANNING_JOIN_SETUP_ENTER_SESSION_CODE_TITLE")
                        .foregroundColor(.accentColor)
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .padding(leading: 20, top: 20, trailing: 20)
                    
                    ClearableTextField(text: $viewModel.sessionCode,
                                       placeholder: "PLANNING_JOIN_SETUP_ENTER_SESSION_CODE_PLACEHOLDER")
                        .padding(leading: 20, top: 15, trailing: 20)
                    
                    qrCodeButton
                    
                    RoundedButton(titleKey: "PLANNING_JOIN_SETUP_JOIN_SESSION_BUTTON_TITLE") {
                        navigateToJoinLanding()
                    }
                    .disabled(!viewModel.inputValid)
                    .padding(leading: 20, top: 10, bottom: 20, trailing: 20)
                }
                
                Spacer()
            }
            .navigationBarTitle("PLANNING_JOIN_TITLE", displayMode: .inline)
            .navigationBarItems(leading:
                CancelBarButton {
                    showSheet.toggle()
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func navigateToJoinLanding() {
        guard viewModel.inputValid else { return }
        let joinLandingView = PlanningJoinSessionLandingView(sessionCode: viewModel.sessionCode,
                                                             participantName: viewModel.participantName)
        navigation.present(AnyView(joinLandingView))
    }
    
    private var qrCodeButton: some View {
        NavigationLink(destination: PlanningJoinSetupQRCameraView(sessionCode: $viewModel.sessionCode, showQrCode: $showQrCode), isActive: $showQrCode) {
            HStack {
                Image(systemName: "qrcode.viewfinder")
                Text("PLANNING_JOIN_SETUP_QR_BUTTON_TITLE")
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(11)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(8)
        }.padding(leading: 20, top: 30, trailing: 20)
    }
}

struct PlanningJoinSetupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlanningJoinSetupView(showSheet: .constant(true))
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
            
            PlanningJoinSetupView(showSheet: .constant(true))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .background(Color.black)
        }
    }
}
