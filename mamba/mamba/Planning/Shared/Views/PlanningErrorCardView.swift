//
//  PlanningErrorCardView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/07.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningErrorCardView: View {
    let error: PlanningLandingError
    let buttonTitle: LocalizedStringKey
    let buttonAction: () -> Void
    
    var body: some View {
        VCardView {
            Image("PlanningError")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(leading: 60, top: 30, bottom: 30, trailing: 60)
                
            Text("PLANNING_ERROR_DESCRIPTION")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .padding(leading: 20, trailing: 20)
            
            Text("Error Code: \(self.error.code)")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .foregroundColor(DefaultStyle.shared.errorRed)
                .padding(leading: 20, top: 15, trailing: 20)
            
            Text(self.error.description)
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .foregroundColor(DefaultStyle.shared.errorRed)
                .padding(leading: 20, top: 10, trailing: 20)
            
            RoundedButton(titleKey: self.buttonTitle) {
                self.buttonAction()
            }
            .padding(leading: 20, top: 20, bottom: 20, trailing: 20)
        }
    }
}

struct PlanningErrorCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlanningErrorCardView(error: PlanningLandingError(code: "200", description: "Invalid session"), buttonTitle: "PLANNING_ERROR_BUTTON_BACK_TO_LANDING_TITLE", buttonAction: {})
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
                .padding()
            
            PlanningErrorCardView(error: PlanningLandingError(code: "200", description: "Invalid session"), buttonTitle: "PLANNING_ERROR_BUTTON_BACK_TO_LANDING_TITLE", buttonAction: {})
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .padding()
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
