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
    @EnvironmentObject var navigation: NavigationStack
    
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
        List(viewModel.landingItems, id: \.self) { item in
            LandingItemView(title: item.titleKey, imageName: item.imageName)
                .onTapGesture { self.landingItemTapped(item) }
        }
    }
    
    var regularView: some View {
        return List {
            ForEach(0 ..< viewModel.chunkedLandingItems.count) { index in
                        HStack {
                            ForEach(self.viewModel.chunkedLandingItems[index], id: \.self) { item in
                                LandingItemView(title: item.titleKey, imageName: item.imageName)
                                    .onTapGesture { self.landingItemTapped(item) }
                                    .padding(.leading, 2)
                                    .padding(.trailing, 2)
                            }
                        }
                    }
        }.padding(.top, 10)
    }
    
    private func landingItemTapped(_ item: LandingItem) {
        switch item {
        case .planningHost:
            self.navigation.push(AnyView(PlanningHostView()))
        case .planningJoin:
            self.navigation.push(AnyView(PlanningJoinView()))
        default:
            return
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LandingView()
                .environment(\.colorScheme, .light)
                .environment(\.horizontalSizeClass, .compact)
                .previewDisplayName("Light mode")

            LandingView()
                .environment(\.colorScheme, .dark)
                .environment(\.horizontalSizeClass, .regular)
                .previewDisplayName("Dark mode")
                .background(Color.black)
                .frame(width: 800, height: 400)
        }.previewLayout(.sizeThatFits)
    }
}
