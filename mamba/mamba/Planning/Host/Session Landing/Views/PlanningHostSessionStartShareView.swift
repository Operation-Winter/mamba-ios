//
//  PlanningHostSessionStartShareView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningHostSessionStartShareView: View {
    let sessionCode: String
    @Binding var showSheet: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                VCardView {
                    TitleText(titleKey: "PLANNING_HOST_LANDING_SESSION_SHARE_MODAL_CODE_TITLE")
                        .padding(leading: 20, top: 20, trailing: 20)
                    
                    SessionCodeText(sessionCode: sessionCode)
                        .padding(leading: 20, top: 40, bottom: 20, trailing: 20)
                }
                Spacer()
            }
            .navigationBarTitle("PLANNING_HOST_LANDING_SESSION_SHARE_MODAL_TITLE", displayMode: .inline)
            .navigationBarItems(trailing:
                DoneBarButton {
                    showSheet.toggle()
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PlanningHostSessionStartShareView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningHostSessionStartShareView(sessionCode: "000000", showSheet: .constant(true))
    }
}
