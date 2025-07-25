//
//  HomeBuilder.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//


import UIKit


enum HomeBuilder {
    static func build(showLoginSuccessBanner: Bool = false) -> UIViewController {
        let view = HomeViewController()
        let presenter = HomePresenter()
        let router = HomeRouter()

        view.presenter = presenter
        view.shouldShowLoginSuccessBanner = showLoginSuccessBanner
        presenter.view = view
        presenter.router = router
        router.viewController = view

        return view
    }
}
