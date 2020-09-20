//
//  MambaApp.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/09/20.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

@main
struct MambaApp: App {
    @StateObject var navigation: NavigationStack = NavigationStack(AnyView(LandingView()))

    var body: some Scene {
        WindowGroup {
            NavigationHost().environmentObject(navigation)
                .onOpenURL(perform: handleUrl)
        }
    }
    
    func handleUrl(_ url: URL?) {
        guard
            let url = url,
            let firstPath = url.pathComponents.element(at: 1)
        else { return }
        
        switch firstPath {
        case "planning":
            navigateToPlanning(pathComponents: url.pathComponents)
        default:
            break
        }
    }
    
    func navigateToPlanning(pathComponents: [String]) {
        switch pathComponents.element(at: 2) {
        case "join":
            guard let sessionCode = pathComponents.element(at: 3) else { return }
            navigateToPlanningJoin(sessionCode: sessionCode)
        default:
            break
        }
    }
    
    func navigateToPlanningJoin(sessionCode: String) {
        DispatchQueue.main.async {
            self.navigation.dismiss()
            self.navigation.present(AnyView(LandingView()))
            let joinSetupView = PlanningJoinSetupView(showSheet: self.$navigation.showSheet)
            joinSetupView.configure(sessionCode: sessionCode)
            self.navigation.modal(AnyView(joinSetupView))
            self.navigation.showSheet = true
    
            Log.planning.logger.info("Deeplinking to Planning Join Code: \(sessionCode)")
        }
    }
}
