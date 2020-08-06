//
//  PlanningHostParticipantRowView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningParticipantRowView: View {
    let participant: PlanningParticipant
    
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 26, height: 26)
                .foregroundColor(.accentColor)
                .padding(leading: 14, top: 9, bottom: 9)
            
            Text(self.participant.name)
                .padding(leading: 15)
                .foregroundColor(.accentColor)
            
            Spacer()
        }
        .background(DefaultStyle.shared.systemGray5)
        .cornerRadius(10)
    }
}

struct PlanningHostParticipantRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlanningParticipantRowView(participant: PlanningParticipant(id: "xxx", name: "Piet Pompies"))
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
            PlanningParticipantRowView(participant: PlanningParticipant(id: "xxx", name: "Piet Pompies"))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
