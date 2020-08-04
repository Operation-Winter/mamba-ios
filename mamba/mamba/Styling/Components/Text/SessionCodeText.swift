//
//  SessionCodeText.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/04.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct SessionCodeText: View {
    let sessionCode: String
    var sessionCodeArray: [String] {
        sessionCode.map { String($0) }
    }
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            CodeText(value: self.sessionCodeArray.element(at: 0) ?? "")
            CodeText(value: self.sessionCodeArray.element(at: 1) ?? "")
            CodeText(value: self.sessionCodeArray.element(at: 2) ?? "")
            CodeText(value: self.sessionCodeArray.element(at: 3) ?? "")
            CodeText(value: self.sessionCodeArray.element(at: 4) ?? "")
            CodeText(value: self.sessionCodeArray.element(at: 5) ?? "")
        }.frame(maxWidth: .infinity)
    }
}

struct SessionCodeText_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SessionCodeText(sessionCode: "000000")
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
            SessionCodeText(sessionCode: "")
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
