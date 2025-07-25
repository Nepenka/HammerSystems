//
//  HomeProtocols.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit



protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    func updateCity(name: String)
    func reloadCategories()
}

protocol HomePresenterProtocol: AnyObject {
    func getCategories() -> [CategoryModel]
    func getSelectedCategoryIndex() -> Int
    func didTapCitySelection()
    func loadSavedCity()
    func getBanners() -> [Banner]
}

protocol HomeRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func showCitySelection(cities: [String], completion: @escaping (String) -> Void)
    func show()
}
