//
//  BasketBuilder.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit


enum CartBuilder {
    static func build() -> UIViewController {
        let view = CartViewController()
        let presenter = CartPresenter()
        let router = CartRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        router.viewController = view

        return view
    }
}


