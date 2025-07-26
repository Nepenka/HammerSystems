//
//  AuthRouter.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit



final class AuthRouter: AuthRouterProtocol  {
   weak var viewController: UIViewController?
    
    func showHomeScreen() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else { return }
        
        let tabBar = MainTabBarController(showLoginSuccessBanner: true)
        
        window.rootViewController = tabBar
    }
}
