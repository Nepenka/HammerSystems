//
//  AuthProtocols.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit




protocol AuthViewProtocol: AnyObject {
    var presenter: AuthPresenterProtocol? {get set}
}

protocol AuthPresenterProtocol: AnyObject {
    var view: AuthViewProtocol? { get set }
    var router: AuthRouterProtocol? { get set }
}

protocol AuthRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func show()
}
