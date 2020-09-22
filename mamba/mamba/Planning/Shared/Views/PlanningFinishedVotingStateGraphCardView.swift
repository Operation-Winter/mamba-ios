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
            
            if !barGraphEntries.isEmpty {
                HorizontalCombinedBarGraphView(barGraphEntries: self.barGraphEntries, barWidth: UIScreen.main.bounds.width - 70)
                    .padding(leading: 20, top: 15, bottom: 20, trailing: 20)
                    .frame(maxWidth: .infinity)
            } else {
                Text("PLANNING_VOTING_FINISHED_NO_VOTES_DESCRIPTION")
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .padding(leading: 20, top: 15, bottom: 20, trailing: 20)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct PlanningFinishedVotingStateGraphCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlanningFinishedVotingStateGraphCardView(barGraphEntries: [
                CombinedBarGraphEntry(title: "5", count: 10),
                CombinedBarGraphEntry(title: "1", count: 2),
                CombinedBarGraphEntry(title: "3", count: 1)
            ])
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
                .padding()
            
            PlanningFinishedVotingStateGraphCardView(barGraphEntries: [])
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .padding()
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
