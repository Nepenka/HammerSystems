//
//  AuthModelBuilder.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit


enum AuthModuleBuilder {
    static func build() -> UIViewController {
        let view = AuthViewController()
        let presenter = AuthPresenter()
        let router = AuthRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        router.viewController = view
        
        return view
    }
}
