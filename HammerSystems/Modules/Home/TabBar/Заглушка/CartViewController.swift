//
//  BasketViewController.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit


final class CartViewController: UIViewController, CartViewProtocol {
    var presenter: CartPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Корзина"
        view.backgroundColor = .systemBackground
    }
}

final class CartPresenter: CartPresenterProtocol {
    weak var view: CartViewProtocol?
    var router: CartRouterProtocol?
}

final class CartRouter: CartRouterProtocol {
    weak var viewController: UIViewController?
}

