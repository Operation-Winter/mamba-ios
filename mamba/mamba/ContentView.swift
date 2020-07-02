//
//  ContentView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/06/25.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let imageNames = [
        "PlanningHost",
        "PlanningJoin",
        "RetroHost",
        "RetroJoin"
    ]
    
    var body: some View {
        VStack {
            ForEach(imageNames, id: \.hashValue) { imageName in
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(30, antialiased: true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
