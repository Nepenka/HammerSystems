//
//  ProfileProtocol.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit




protocol ProfileViewProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
}

protocol ProfilePresenterProtocol: AnyObject {
    var view: ProfileViewProtocol? { get set }
    var router: ProfileRouterProtocol? { get set }
}

protocol ProfileRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
}
