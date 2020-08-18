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
    @ObservedObject private var viewModel = PlanningJoinSetupViewModel()
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
                    
                    ClearableTextField(text: self.$viewModel.participantName,
                                       placeholder: "PLANNING_JOIN_SETUP_NAME_PLACEHOLDER")
                        .padding(leading: 20, top: 10, trailing: 20)
                    
                    Text("PLANNING_JOIN_SETUP_ENTER_SESSION_CODE_TITLE")
                        .foregroundColor(.accentColor)
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .padding(leading: 20, top: 20, trailing: 20)
                    
                    SessionCodeTextField(code1: self.$viewModel.sessionCode1,
                                         code2: self.$viewModel.sessionCode2,
                                         code3: self.$viewModel.sessionCode3,
                                         code4: self.$viewModel.sessionCode4,
                                         code5: self.$viewModel.sessionCode5,
                                         code6: self.$viewModel.sessionCode6)
                        .padding(leading: 20, top: 15, trailing: 20)
                    
                    RoundedButton(titleKey: "PLANNING_JOIN_SETUP_JOIN_SESSION_BUTTON_TITLE") {
                        self.navigateToJoinLanding()
                    }
                    .disabled(!self.viewModel.inputValid)
                    .padding(leading: 20, top: 20, bottom: 20, trailing: 20)
                }
                
                Spacer()
            }
            .navigationBarTitle("PLANNING_JOIN_TITLE", displayMode: .inline)
            .navigationBarItems(leading:
                CancelBarButton {
                    self.showSheet.toggle()
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func navigateToJoinLanding() {
        guard let sessionCode = viewModel.sessionCode else { return }
        let joinLandingView = PlanningJoinSessionLandingView(sessionCode: sessionCode, participantName: viewModel.participantName)
        navigation.present(AnyView(joinLandingView))
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
