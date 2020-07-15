//
//  PlanningHostSetupView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/02.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct PlanningHostSetupView: View {
    @EnvironmentObject var navigation: NavigationStack
    @ObservedObject var viewModel = PlanningHostSetupViewModel()
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("PLANNING HOST SETUP")
                    .foregroundColor(.accentColor)
                    .font(.title)
                    .padding()
                
                ClearableTextField(text: self.$viewModel.sessionName)
                
                Spacer()
                Button(action: {
                    self.navigation.dismiss()
                }) {
                    Text("Dismiss")
                }
                Spacer()
            }
            Spacer()
        }.onAppear {
            self.viewModel.sendCommand()
        }
    }
}

struct PlanningHostSetupView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningHostSetupView()
    }
}
