//
//  SplashProtocols.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit



protocol SplashViewProtocol: AnyObject {
    var presenter: SplashPresenterProtocol? { get set }
}

protocol SplashPresenterProtocol: AnyObject {
    var view: SplashViewProtocol? { get set }
    var router: SplashRouterProtocol? { get set }

    func viewDidLoad()
}

protocol SplashRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func showAuthScreen()
}
