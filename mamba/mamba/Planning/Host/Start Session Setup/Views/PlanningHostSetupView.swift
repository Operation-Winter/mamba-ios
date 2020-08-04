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
                VCardView {
                    TitleText(titleKey: "PLANNING_HOST_SETUP_TITLE")
                        .padding(leading: 20, top: 20, trailing: 20)
                    
                    ClearableTextField(text: self.$viewModel.sessionName,
                                       placeholder: "PLANNING_HOST_START_SESSION_NAME_PLACEHOLDER")
                        .padding(leading: 20, top: 10, trailing: 20)
                    
                    SelectCardsButton(cardCount: self.viewModel.selectedCardsCountTitle, destination: PlanningHostAvailableCardsView(availableCards: self.viewModel.availableCards))
                    .padding(leading: 20, top: 15, trailing: 20)
    
                    RoundedButton(titleKey: "PLANNING_HOST_START_SESSION_BUTTON_TITLE") {
                        self.navigateToHostLanding()
                    }
                    .disabled(!self.viewModel.inputValid)
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
    
    private func navigateToHostLanding() {
        // TODO: MAM-29 - Validation of input data
        let planningCards: [PlanningCard] = self.viewModel.availableCards.compactMap {
            guard $0.selected else { return nil }
            return $0.card
        }
        let hostLandingView = PlanningHostSessionLandingView(sessionName: self.viewModel.sessionName, availableCards: planningCards)
        navigation.present(AnyView(hostLandingView))
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
