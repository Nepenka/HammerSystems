//
//  NetworkService.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 25/07/2025.
//

import UIKit
import Alamofire

protocol NetworkServiceProtocol {
func request<T: Decodable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void)
}
final class NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(endpoint).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
