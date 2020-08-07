//
//  PlanningHostVotingStateCardView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningVotingStateTicketCardView: View {
    let title: String
    let ticketIdentifier: String?
    let ticketDescription: String?
    
    var body: some View {
        let identifier = self.ticketIdentifier ?? NSLocalizedString("PLANNING_TICKET_NO_IDENTIFIER_DESCRIPTION", comment: "No identifier")
        let description = self.ticketDescription ?? NSLocalizedString("PLANNING_TICKET_NO_DESCRIPTION_DESCRIPTION", comment: "No description")
        
        return VCardView {
            Text(self.title)
                .font(.system(size: 20))
                .foregroundColor(.accentColor)
                .padding(leading: 20, top: 20, trailing: 20)
                .frame(minWidth: 0, maxWidth: .infinity)
            
            Text("PLANNING_TICKET_IDENTIFIER_TITLE")
                .font(.system(size: 16))
                .foregroundColor(.accentColor)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(leading: 20, top: 15, trailing: 20)
            
            Text(identifier)
                .font(.system(size: 14))
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(leading: 20, top: 5, trailing: 20)
            
            Text("PLANNING_TICKET_DESCRIPTION_TITLE")
                .font(.system(size: 16))
                .foregroundColor(.accentColor)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(leading: 20, top: 15, trailing: 20)
            
            Text(description)
                .font(.system(size: 14))
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(leading: 20, top: 5, bottom: 20, trailing: 20)
        }
    }
}

struct PlanningHostVotingStateCardView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            PlanningVotingStateTicketCardView(title: "Planning 1", ticketIdentifier: "MAM-29", ticketDescription: "Test x and y")
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
                .padding()
            
            PlanningVotingStateTicketCardView(title: "Planning 1", ticketIdentifier: nil, ticketDescription: nil)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .padding()
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
