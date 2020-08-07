//
//  AddTicketView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningAddTicketView: View {
    @ObservedObject private var viewModel = PlanningAddTicketViewModel()
    @Binding var showSheet: Bool
    
    let doneTapped: (_ identifier: String, _ description: String) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                VCardView {
                    Text("Ticket details")
                        .foregroundColor(.accentColor)
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .padding(leading: 20, top: 20, trailing: 20)
                    
                    ClearableTextField(text: self.$viewModel.ticketIdentifier,
                                       placeholder: "PLANNING_HOST_ADD_TICKET_IDENTIFIER_PLACEHOLDER")
                        .padding(leading: 20, top: 10, trailing: 20)
                    
                    ClearableTextField(text: self.$viewModel.ticketDescription,
                                       placeholder: "PLANNING_HOST_ADD_TICKET_DESCRIPTION_PLACEHOLDER")
                        .padding(leading: 20, top: 10, bottom: 20, trailing: 20)
                }
                
                Spacer()
            }
            .navigationBarTitle("PLANNING_HOST_LANDING_ADD_TICKET_MODAL_TITLE", displayMode: .inline)
            .navigationBarItems(leading: CancelBarButton { self.showSheet.toggle() },
                                trailing: AddBarButton {
                                    self.doneTapped(self.viewModel.ticketIdentifier, self.viewModel.ticketDescription)
                                    self.showSheet.toggle()
                                }.disabled(!self.viewModel.isInputValid))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PlanningAddTicketView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningAddTicketView(showSheet: .constant(true), doneTapped: {_,_ in })
    }
}
