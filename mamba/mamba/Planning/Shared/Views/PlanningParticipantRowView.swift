//
//  PlanningHostParticipantRowView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningParticipantRowView: View {
    let viewModel: PlanningParticipantRowViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 26, height: 26)
                .foregroundColor(.accentColor)
                .padding(leading: 14, top: 9, bottom: 9)
            
            Text(self.viewModel.participantName)
                .padding(leading: 15)
                .foregroundColor(.accentColor)
            
            Spacer()
            
            if !self.viewModel.votingValue.isEmpty {
                Text(self.viewModel.votingValue)
                    .foregroundColor(.accentColor)
                    .padding(top: 9, bottom: 9, trailing: 14)
            }
        }
        .background(DefaultStyle.shared.systemGray5)
        .cornerRadius(10)
    }
}

struct PlanningHostParticipantRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlanningParticipantRowView(viewModel: PlanningParticipantRowViewModel(participantName: "Piet Pompies", votingValue: ""))
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
            
            PlanningParticipantRowView(viewModel: PlanningParticipantRowViewModel(participantName: "Piet Pompies", votingValue: "5"))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
