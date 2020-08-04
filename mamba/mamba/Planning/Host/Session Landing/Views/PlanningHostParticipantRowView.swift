//
//  PlanningHostParticipantRowView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningHostParticipantRowView: View {
    let participant: PlanningParticipant
    
    var body: some View {
        HCardView {
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
    }
}

struct PlanningHostParticipantRowView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningHostParticipantRowView(participant: PlanningParticipant(id: "xxx", name: "Piet Pompies"))
    }
}
