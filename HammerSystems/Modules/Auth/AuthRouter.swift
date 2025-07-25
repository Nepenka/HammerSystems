//
//  AuthRouter.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit



final class AuthRouter: AuthRouterProtocol  {
    var viewController: UIViewController?
    
    func showHomeScreen() {
        let homeVC = HomeBuilder.build(showLoginSuccessBanner: true)
        viewController?.navigationController?.pushViewController(homeVC, animated: true)
    }
}
