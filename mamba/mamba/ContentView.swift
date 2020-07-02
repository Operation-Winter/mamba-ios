//
//  ContentView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/02.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationHost()
            .environmentObject(NavigationStack(AnyView(LandingView())))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
