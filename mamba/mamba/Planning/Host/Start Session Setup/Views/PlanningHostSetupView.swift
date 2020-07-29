//
//  PlanningHostSetupView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/02.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningHostSetupView: View {
    @EnvironmentObject private var navigation: NavigationStack
    @ObservedObject private var viewModel = PlanningHostSetupViewModel()
    @Binding var showSheet: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                CardView {
                    TitleText(titleKey: "PLANNING_HOST_SETUP_TITLE")
                        .padding(leading: 20, top: 20, trailing: 20)
                    
                    ClearableTextField(text: self.$viewModel.sessionName,
                                       placeholder: "PLANNING_HOST_START_SESSION_NAME_PLACEHOLDER")
                        .padding(leading: 20, top: 10, trailing: 20)
                    
                    SelectCardsButton(cardCount: self.viewModel.selectedCardsCountTitle) {
                        // TODO: MAM-27
                    }
                    .padding(leading: 20, top: 15, trailing: 20)
    
                    RoundedButton(titleKey: "PLANNING_HOST_START_SESSION_BUTTON_TITLE") {
                        // TODO: MAM-29
                    }
                    .padding(leading: 20, top: 20, bottom: 20, trailing: 20)
                }
                
                Spacer()
            }
            .navigationBarTitle("PLANNING_HOST_TITLE", displayMode: .inline)
            .navigationBarItems(leading:
                CancelBarButton {
                    self.showSheet.toggle()
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func navigateToHostSession() {
        self.navigation.present(AnyView(PlanningJoinView()))
    }
}

struct PlanningHostSetupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlanningHostSetupView(showSheet: .constant(true))
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
            
            PlanningHostSetupView(showSheet: .constant(true))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .background(Color.black)
        }
    }
}
