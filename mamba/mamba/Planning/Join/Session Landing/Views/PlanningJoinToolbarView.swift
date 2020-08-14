//
//  PlanningJoinToolbarView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/14.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningJoinToolbarView: View {
    let shareAction: () -> Void
    let menuAction: () -> Void
    
    var body: some View {
        HStack {
            SystemImageButton(imageSystemName: "square.and.arrow.up", action: shareAction)
                .disabled(true)
            
            Spacer()
            
            SystemImageButton(imageSystemName: "slider.horizontal.3", action: menuAction)
                .disabled(true)
        }
            .padding()
            .background(
                DefaultStyle.shared.systemGray6
                    .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
            )
    }
}

struct PlanningJoinToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningJoinToolbarView(shareAction: {}, menuAction: {})
    }
}
