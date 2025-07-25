//
//  Contact.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit





enum ContactBuilder {
    static func build() -> UIViewController {
        let view = ContactViewController()
        let presenter = ContactPresenter()
        let router = ContactRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        router.viewController = view

        return view
    }
}

