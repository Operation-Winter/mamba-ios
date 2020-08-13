//
//  PlanningFinishedVotingStateGraphCardView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningFinishedVotingStateGraphCardView: View {
    let barGraphEntries: [CombinedBarGraphEntry]
    
    var body: some View {
        VCardView {
            Text("PLANNING_FINISHED_STATE_VOTING_RESULTS_TITLE")
                .font(.system(size: 16))
                .foregroundColor(.accentColor)
                .multilineTextAlignment(.center)
                .padding(leading: 20, top: 15, trailing: 20)
            
            HorizontalCombinedBarGraphView(barGraphEntries: self.barGraphEntries)
            .padding(leading: 20, top: 15, bottom: 20, trailing: 20)
        }
    }
}

struct PlanningFinishedVotingStateGraphCardView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningFinishedVotingStateGraphCardView(barGraphEntries: [
            CombinedBarGraphEntry(title: "5", count: 8),
            CombinedBarGraphEntry(title: "1", count: 2)
        ])
    }
}