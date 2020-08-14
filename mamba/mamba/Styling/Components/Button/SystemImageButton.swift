//
//  SystemImageButton.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/14.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct SystemImageButton: View {
    let imageSystemName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: imageSystemName)
                .imageScale(.medium)
        }
    }
}

struct SystemImageButton_Previews: PreviewProvider {
    static var previews: some View {
        SystemImageButton(imageSystemName: "plus") {}
    }
}
