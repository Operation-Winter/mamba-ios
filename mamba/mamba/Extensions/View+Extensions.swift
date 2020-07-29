//
//  View+Extensions.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/29.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

extension View {
    @inlinable public func padding(leading: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> some View {
        self
            .padding(.leading, leading)
            .padding(.top, top)
            .padding(.bottom, bottom)
            .padding(.trailing, trailing)
    }
}
