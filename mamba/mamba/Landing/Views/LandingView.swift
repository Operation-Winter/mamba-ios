//
//  LandingView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/06/25.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct LandingView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    private let viewModel = LandingViewModel()
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        Group {
            if sizeClass == .compact {
                compactView
            } else {
                regularView
            }
        }
    }
    
    var compactView: some View {
        List(viewModel.landingItems) { item in
            LandingItemView(title: item.title, imageName: item.imageName)
        }
    }
    
    var regularView: some View {
        let chunkedLandingItems = viewModel.landingItems.chunked(into: 2)
        return List {
                    ForEach(0..<chunkedLandingItems.count) { index in
                        HStack {
                            ForEach(chunkedLandingItems[index]) { item in
                                LandingItemView(title: item.title, imageName: item.imageName)
                                .padding(.leading, 2)
                                .padding(.trailing, 2)
                            }
                        }
                    }
        }.padding(.top, 10)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LandingView()
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")

            LandingView()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .background(Color.black)
        }
    }
}
