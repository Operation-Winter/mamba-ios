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
    @Published var showSheet: Bool
    @Published var accentColor: Color?
    private(set) var modalView: AnyView
    private var viewStack: [AnyView] = []
    private(set) var userAction: NavigationAction
    
    init(_ currentView: AnyView) {
        userAction = .none
        self.currentView = currentView
        self.modalView = AnyView(EmptyView())
        self.showSheet = false
    }
    
    func present(_ view: AnyView, colorScheme: Product? = nil) {
        viewStack.append(currentView)
        userAction = .present
        
        if showSheet { showSheet.toggle() }
        
        withAnimation {
            currentView = view
        }
        setColorScheme(colorScheme)
    }
    
    func modal(_ view: AnyView, colorScheme: Product? = nil) {
        modalView = view
        setColorScheme(colorScheme)
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
    
    func setColorScheme(_ product: Product?) {
        guard let product = product else { return }
        DefaultStyle.shared.setColorScheme(product: product)
        accentColor = DefaultStyle.shared.accent
    }
}

