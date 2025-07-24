//
//  SplashModuleBuilder.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit



enum SplashModuleBuilder {
    static func build() -> UIViewController {
        let view = SplashViewController()
        let presenter = SplashPresenter()
        let router = SplashRouter()
        
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        router.viewController = view
        
        return view
    }
}
