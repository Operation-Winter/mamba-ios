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
        self.navigation.currentView
    } 
}

struct NavigationHost_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHost()
    }
}
