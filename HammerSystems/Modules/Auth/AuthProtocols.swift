//
//  AuthProtocols.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit




protocol AuthViewProtocol: AnyObject {
    var presenter: AuthPresenterProtocol? {get set}
    func showBanner(message: String, iconName: String, color: UIColor)
}

protocol AuthPresenterProtocol: AnyObject {
    func login(username: String?, password: String?)
}

protocol AuthRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func showHomeScreen()
}
