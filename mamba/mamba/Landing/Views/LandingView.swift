//
//  LandingView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/06/25.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct LandingView: View {
    private let viewModel = LandingViewModel()
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        List(viewModel.landingItems) { item in
            LandingItemView(title: item.title, imageName: item.imageName)
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
