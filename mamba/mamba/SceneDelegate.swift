//
//  SceneDelegate.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/06/25.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    @ObservedObject var navigation: NavigationStack = NavigationStack(AnyView(LandingView()))

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let navigationHost = NavigationHost().environmentObject(navigation)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: navigationHost)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        guard
            userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let urlToOpen = userActivity.webpageURL else { return }

        handleUrl(urlToOpen)
    }
    
    func handleUrl(_ url: URL) {
        guard let firstPath = url.pathComponents.element(at: 1) else { return }
        switch firstPath {
        case "planning":
            navigateToPlanning(pathComponents: url.pathComponents)
        default:
            return
        }
    }
    
    func navigateToPlanning(pathComponents: [String]) {
        switch pathComponents.element(at: 2) {
        case "join":
            guard let sessionCode = pathComponents.element(at: 3) else { return }
            navigateToPlanningJoin(sessionCode: sessionCode)
        default:
            return
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
            
            Log.log(level: .info, category: .planning, message: "Deeplinking to Planning Join Code: %@", args: sessionCode)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

}
