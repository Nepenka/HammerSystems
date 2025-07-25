//
//  HomePresenter.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit



final class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewProtocol?
    var router: HomeRouterProtocol?
    
    private let categoryAPI: CategoryAPIProtocol
    private(set) var categories: [CategoryModel] = []
    private(set) var selectedIndex: Int = 0
    private(set) var subMenus: [String: [Dish]] = [:]
    
    private let availableCities = ["Москва", "Санкт-Петербург", "Казань", "Новосибирск"]
    private let banners: [Banner] = [
        Banner(imageName: "first"),
        Banner(imageName: "second2"),
        Banner(imageName: "third"),
        Banner(imageName: "four")
    ]
    
    init(view: HomeViewProtocol? = nil, router: HomeRouterProtocol? = nil) {
        self.view = view
        self.router = router
        let networkService = NetworkService() 
        self.categoryAPI = CategoryAPI(networkService: networkService)
        
        fetchCategories()
        selectedIndex = 0
        categories = []
    }
    
    func getCategories() -> [CategoryModel] {
        return categories
    }
    
    func getSelectedCategoryIndex() -> Int {
        return selectedIndex
    }
    
    func getBanners() -> [Banner] {
        return banners
    }
    
    func fetchCategories() {
        categoryAPI.fetchCategories { [weak self] result in
            switch result {
            case .success(let data):
                self?.categories = data
                DispatchQueue.main.async {
                    self?.view?.reloadCategories()
                }
            case .failure(let error):
                print("Error fetching categories: \(error)")
            }
        }
    }
    
    func fetchSubMenu(for category: CategoryModel, completion: @escaping () -> Void) {
        categoryAPI.fetchSubMenu(menuID: category.menuID) { [weak self] result in
            switch result {
            case .success(let dishes):
                self?.subMenus[category.menuID] = dishes
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let error):
                print("Ошибка загрузки подменю: \(error)")
            }
        }
    }
    
    func getDishes(for menuID: String) -> [Dish] {
        return subMenus[menuID] ?? []
    }

    
    func didTapCitySelection() {
        router?.showCitySelection(cities: availableCities) { [weak self] selectedCity in
            UserDefaults.standard.setValue(selectedCity, forKey: "selectedCity")
            self?.view?.updateCity(name: selectedCity)
        }
    }
    
    func loadSavedCity() {
        let savedCity = UserDefaults.standard.string(forKey: "selectedCity") ?? "Москва"
        view?.updateCity(name: savedCity)
    }
}

