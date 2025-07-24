//
//  SplashRouter.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit




final class SplashRouter: SplashRouterProtocol {
    weak var viewController: UIViewController?
    
    
    func showAuthScreen() {
        let authVC = AuthModuleBuilder.build()
        let nav = UINavigationController(rootViewController: authVC)
        nav.modalPresentationStyle = .fullScreen
        viewController?.present(nav, animated: true)
    }
}
