//
//  NavigationStack.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/02.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

enum NavigationAction {
    case present
    case dismiss
    case none
}

final class NavigationStack: ObservableObject {
    @Published var currentView: AnyView
    @Published var accentColor: Color?
    var viewStack: [AnyView] = []
    var userAction: NavigationAction
    
    init(_ currentView: AnyView) {
        userAction = .none
        self.currentView = currentView
    }
    
    func present(_ view: AnyView, colorScheme: Product? = nil) {
        viewStack.append(currentView)
        userAction = .present
        withAnimation {
            currentView = view
        }
        
        if let colorScheme = colorScheme {
            DefaultStyle.shared.setColorScheme(product: colorScheme)
            accentColor = DefaultStyle.shared.colorScheme.accent()
        }
    }
    
    func dismiss() {
        let index = viewStack.endIndex - 1
        guard let lastView = viewStack.element(at: index) else { return }
        userAction = .dismiss
        withAnimation {
            currentView = lastView
        }
        viewStack.remove(at: index)
    }
}

