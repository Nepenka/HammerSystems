//
//  BasketProtocol.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit



protocol CartViewProtocol: AnyObject {
    var presenter: CartPresenterProtocol? { get set }
}

protocol CartPresenterProtocol: AnyObject {
    var view: CartViewProtocol? { get set }
    var router: CartRouterProtocol? { get set }
}

protocol CartRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
}

