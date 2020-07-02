//
//  NavigationStack.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/02.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

final class NavigationStack: ObservableObject {
    @Published var viewStack: [AnyView] = []
    @Published var currentView: AnyView
    
    init(_ currentView: AnyView) {
        self.currentView = currentView
    }
    
    func advance(_ view: AnyView) {
        viewStack.append(currentView)
        self.currentView = view
    }
    
    func unwind() {
        guard viewStack.count > 0 else { return }
        let last = viewStack.endIndex - 1
        currentView = viewStack[last]
        viewStack.remove(at: last)
    }
}
