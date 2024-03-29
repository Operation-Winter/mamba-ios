//
//  NavigationHost.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/02.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct NavigationHost: View {
    @EnvironmentObject var navigation: NavigationStack
    
    var body: some View {
        ZStack {
            if self.navigation.userAction == .none {
                self.navigation.currentView
            }
            
            if self.navigation.userAction == .present {
                self.navigation.currentView
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    .animation(.easeInOut, value: self.navigation.userAction)
            }
            
            if self.navigation.userAction == .dismiss {
                self.navigation.currentView
                    .transition(.opacity)
                    .animation(.easeInOut, value: self.navigation.userAction)
            }
        }.sheet(isPresented: self.$navigation.showSheet, content: {
            self.navigation.modalView
                .environmentObject(self.navigation)
                .accentColor(self.navigation.accentColor)
        })
        .accentColor(self.navigation.accentColor)
    }
}

struct NavigationHost_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHost()
    }
}
