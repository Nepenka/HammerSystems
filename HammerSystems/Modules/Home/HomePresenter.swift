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
    
    private let availableCities = ["Москва", "Санкт-Петербург", "Казань", "Новосибирск"]
    private let banners: [Banner] = [
        Banner(imageName: "first"),
        Banner(imageName: "second2"),
        Banner(imageName: "third")
    ]
    
    // Инициализатор без параметров, где создаём categoryAPI внутри
    init(view: HomeViewProtocol? = nil, router: HomeRouterProtocol? = nil) {
        self.view = view
        self.router = router
        // Создаем categoryAPI тут сами, чтобы не тащить из вне
        let networkService = NetworkService() // или твоя реализация
        self.categoryAPI = CategoryAPI(networkService: networkService)
        
        // Можно сразу загрузить категории (если нужно)
        fetchCategories()
        
        // Можно грузить выбранный индекс и категории из UserDefaults или из дефолта
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

