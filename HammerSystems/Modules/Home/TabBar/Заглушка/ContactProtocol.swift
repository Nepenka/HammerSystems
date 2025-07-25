//
//  ContactProtocol.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit



protocol ContactViewProtocol: AnyObject {
    var presenter: ContactPresenterProtocol? { get set }
}

protocol ContactPresenterProtocol: AnyObject {
    var view: ContactViewProtocol? { get set }
    var router: ContactRouterProtocol? { get set }
}

protocol ContactRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
}

