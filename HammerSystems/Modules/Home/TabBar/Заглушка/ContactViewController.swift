//
//  ContactViewController.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit



final class ContactViewController: UIViewController, ContactViewProtocol {
    var presenter: ContactPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Контакты"
        view.backgroundColor = .systemBackground
    }
}

final class ContactPresenter: ContactPresenterProtocol {
    weak var view: ContactViewProtocol?
    var router: ContactRouterProtocol?
}

final class ContactRouter: ContactRouterProtocol {
    weak var viewController: UIViewController?
}

