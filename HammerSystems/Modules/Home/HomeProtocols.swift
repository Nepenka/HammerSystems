//
//  HomeProtocols.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit



protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
}

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
}

protocol HomeRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func show()
}
