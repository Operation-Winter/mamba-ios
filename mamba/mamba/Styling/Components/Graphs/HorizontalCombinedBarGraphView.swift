//
//  HorizontalCombinedBarGraphView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct HorizontalCombinedBarGraphView: View {
    let barGraphEntries: [CombinedBarGraphEntry]
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(self.barGraphEntries.indices) { index in
                ZStack(alignment: .center) {
                    Rectangle()
                        .fill(self.color(index: index))
                        .frame(height: 30)
                        .aspectRatio(self.aspectRatio(index: index), contentMode: .fit)
                    
                    StrokeText(text: self.barGraphEntries[index].title, width: 0.5, color: DefaultStyle.shared.accent)
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    private func color(index: Int) -> Color {
        let mainColor = DefaultStyle.shared.uiPrimary
        guard barGraphEntries.count != 0 else { return Color(mainColor) }
        let alpha = 1 - CGFloat(index) / CGFloat(barGraphEntries.count)
        return Color(mainColor.withAlphaComponent(alpha))
    }
    
    private func widthRatio(index: Int) -> CGFloat {
        guard barGraphEntries.count != 0 else { return 1 }
        let voteCount = barGraphEntries[index].count
        let totalVotesCount = barGraphEntries.reduce(0) { $0 + $1.count }
        return CGFloat(voteCount) / CGFloat(totalVotesCount)
    }
    
    private func aspectRatio(index: Int) -> CGFloat {
        let ratio = widthRatio(index: index)
        let width = UIScreen.main.bounds.width
        return (ratio * width) / 30
    }
}

struct HorizontalCombinedBarGraphView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HorizontalCombinedBarGraphView(barGraphEntries: [
                CombinedBarGraphEntry(title: "5", count: 6),
                CombinedBarGraphEntry(title: "1", count: 3),
                CombinedBarGraphEntry(title: "8", count: 2)
            ])
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
                .padding()
            
            HorizontalCombinedBarGraphView(barGraphEntries: [
                CombinedBarGraphEntry(title: "5", count: 6),
                CombinedBarGraphEntry(title: "1", count: 3),
                CombinedBarGraphEntry(title: "8", count: 2)
            ])
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .padding()
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
