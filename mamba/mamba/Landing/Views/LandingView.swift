//
//  LandingView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/06/25.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct LandingView: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    @EnvironmentObject private var navigation: NavigationStack
    private let viewModel = LandingViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: viewModel.gridItems) {
                ForEach(viewModel.landingItems, id: \.self) { item in
                    LandingItemView(title: item.titleKey, imageName: item.imageName)
                        .onTapGesture { self.landingItemTapped(item) }
                }
            }.padding(10)
        }
    }
    
    private func landingItemTapped(_ item: LandingItem) {
        switch item {
        case .planningHost:
            navigation.modal(AnyView(PlanningHostSetupView(showSheet: $navigation.showSheet)), colorScheme: .planning)
            navigation.showSheet.toggle()
        case .planningJoin:
            navigation.modal(AnyView(PlanningJoinSetupView(showSheet: $navigation.showSheet)), colorScheme: .planning)
            navigation.showSheet.toggle()
        default:
            break
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
