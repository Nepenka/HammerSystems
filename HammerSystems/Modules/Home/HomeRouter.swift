//
//  HomeRouter.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit



final class HomeRouter: HomeRouterProtocol {
    
    weak var viewController: UIViewController?

    func showCitySelection(cities: [String], completion onSelect: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "Выберите город", message: nil, preferredStyle: .actionSheet)
        
        for city in cities {
            alert.addAction(UIAlertAction(title: city, style: .default) { _ in
                onSelect(city)
            })
        }
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        viewController?.present(alert, animated: true)
    }
    
    func show() {
        print("123")
    }
}
