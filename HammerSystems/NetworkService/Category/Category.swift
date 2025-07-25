//
//  Category.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 25/07/2025.
//

import UIKit



struct CategoryModel: Decodable {
    let menuID: String
    let name: String
}


struct CategoryResponse: Decodable {
    let status: Bool
    let menuList: [CategoryModel]
}



