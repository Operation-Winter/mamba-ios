//
//  SystemImageTextButton.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/14.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct ContextMenuButton: View {
    let title: LocalizedStringKey
    let imageSystemName: String
    let action: () -> Void
    
    private var uiImage: UIImage? {
        UIImage(systemName: imageSystemName)
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                
                if self.uiImage != nil {
                    Image(uiImage: uiImage!)
                }
            }
        }
    }
}

struct SystemImageTextButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContextMenuButton(title: "PLANNING_HOST_PARTICIPANT_SKIP_VOTE", imageSystemName: "arrowshape.turn.up.right", action: {})
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
                .padding()
            
            ContextMenuButton(title: "PLANNING_HOST_PARTICIPANT_SKIP_VOTE", imageSystemName: "arrowshape.turn.up.right", action: {})
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .padding()
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
