//
//  CategoryAPI.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 25/07/2025.
//

import UIKit


protocol CategoryAPIProtocol {
    func fetchCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
}

final class CategoryAPI: CategoryAPIProtocol {
    private let networkService: NetworkServiceProtocol
    private let url = "https://vkus-sovet.ru/api/getMenu.php"

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        networkService.request(endpoint: url) { (result: Result<CategoryResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.menuList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
