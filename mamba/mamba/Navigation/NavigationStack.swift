//
//  NavigationStack.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/02.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

enum NavigationAction {
    case push
    case pop
    case none
}

final class NavigationStack: ObservableObject {
    @Published var currentView: AnyView
    var viewStack: [AnyView] = []
    var userAction: NavigationAction
    
    init(_ currentView: AnyView) {
        userAction = .none
        self.currentView = currentView
    }
    
    func push(_ view: AnyView) {
        viewStack.append(currentView)
        userAction = .push
        withAnimation {
            currentView = view
        }
    }
    
    func pop() {
        let index = viewStack.endIndex - 1
        guard let lastView = viewStack.element(at: index) else { return }
        userAction = .pop
        withAnimation {
            currentView = lastView
        }
        viewStack.remove(at: index)
    }
}

