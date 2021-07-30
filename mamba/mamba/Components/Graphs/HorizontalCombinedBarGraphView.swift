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
        SingleAxisGeometryReader { width in
            HStack(alignment: .top, spacing: 0) {
                ForEach(self.barGraphEntries.indices, id: \.self) { index in
                    ZStack(alignment: .center) {
                        Rectangle()
                            .fill(self.color(index: index))
                            .frame(width: self.entryWidth(index: index, barWidth: width), height: 30)
                        
                        StrokeText(text: self.barGraphEntries[index].title, width: 0.5, color: DefaultStyle.shared.accent)
                            .foregroundColor(.white)
                    }
                }
            }.frame(width: width)
        }
    }
    
    private func color(index: Int) -> Color {
        let mainColor = DefaultStyle.shared.primary
        guard barGraphEntries.count != 0 else { return mainColor }
        let alpha = 1 - Double(index) / Double(barGraphEntries.count)
        return mainColor.opacity(alpha)
    }
    
    private func widthRatio(index: Int) -> CGFloat {
        guard barGraphEntries.count != 0 else { return 1 }
        let voteCount = barGraphEntries[index].count
        let totalVotesCount = barGraphEntries.reduce(0) { $0 + $1.count }
        return CGFloat(voteCount) / CGFloat(totalVotesCount)
    }
    
    private func entryWidth(index: Int, barWidth: CGFloat) -> CGFloat {
        let ratio = widthRatio(index: index)
        return ratio * barWidth
    }
}

struct HorizontalCombinedBarGraphView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HorizontalCombinedBarGraphView(barGraphEntries: [
                CombinedBarGraphEntry(title: "5", count: 2),
                CombinedBarGraphEntry(title: "1", count: 1),
                CombinedBarGraphEntry(title: "8", count: 1)
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
