//
//  ProfileBuilder.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit



enum ProfileBuilder {
    static func build() -> UIViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        router.viewController = view

        return view
    }
}
