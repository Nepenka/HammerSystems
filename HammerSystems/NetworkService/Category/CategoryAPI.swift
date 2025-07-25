//
//  CategoryAPI.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 25/07/2025.
//

import UIKit
import Alamofire

protocol CategoryAPIProtocol {
    func fetchCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
    func fetchSubMenu(menuID: String, completion: @escaping (Result<[Dish], Error>) -> Void)
}

final class CategoryAPI: CategoryAPIProtocol {
    private let networkService: NetworkServiceProtocol
    private let url = "https://vkus-sovet.ru/api/getMenu.php"

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        networkService.request(endpoint: url, method: .get, parameters: nil) { (result: Result<CategoryResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.menuList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension CategoryAPI {
    func fetchSubMenu(menuID: String, completion: @escaping (Result<[Dish], Error>) -> Void) {
        let sub = "https://vkus-sovet.ru/api/getSubMenu.php"
        let parameters: Parameters = ["menuID": menuID]

        networkService.request(
            endpoint: sub,
            method: .post,
            parameters: parameters
         ){ (result: Result<SubMenuResponse, Error>) in
            switch result {
            case .success(let response):
                if response.status {
                    completion(.success(response.menuList))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Не верный ID или нет данных"])
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
