//
//  SceneDelegate.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        if AuthStorage.isLoggedIn {
            let tabBar = MainTabBarController()
            window.rootViewController = tabBar
        } else {
            let splashVC = SplashModuleBuilder.build()
            window.rootViewController = splashVC
        }
        
        self.window = window
        window.makeKeyAndVisible()
    }
}

