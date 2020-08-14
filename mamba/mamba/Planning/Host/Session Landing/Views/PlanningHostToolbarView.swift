//
//  PlanningHostToolbarView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/14.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningHostToolbarView: View {
    let revoteDisabled: Bool
    let addTicketAction: () -> Void
    let revoteAction: () -> Void
    let shareAction: () -> Void
    let menuAction: () -> Void
    
    var body: some View {
        HStack {
            SystemImageButton(imageSystemName: "plus", action: addTicketAction)
            
            Spacer()
            
            SystemImageButton(imageSystemName: "arrow.counterclockwise", action: revoteAction)
                .disabled(revoteDisabled)
            
            Spacer()

            SystemImageButton(imageSystemName: "square.and.arrow.up", action: shareAction)
                .disabled(true)
            
            Spacer()

            SystemImageButton(imageSystemName: "slider.horizontal.3", action: menuAction)
        }
        .padding()
        .background(
            DefaultStyle.shared.systemGray6
                .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
        )
    }
}

struct PlanningHostToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningHostToolbarView(revoteDisabled: true, addTicketAction: {}, revoteAction: {}, shareAction: {}, menuAction: {})
    }
}
