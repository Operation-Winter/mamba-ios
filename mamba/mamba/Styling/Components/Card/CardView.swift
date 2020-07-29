//
//  CardView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/29.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct CardView<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            content()
        }
        .background(Color(red: 240 / 255, green: 240 / 255, blue: 240 / 255))
        .cornerRadius(10)
        .padding(15)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView {
            Text("Hi")
        }
    }
}
