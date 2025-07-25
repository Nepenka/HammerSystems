//
//  СategoryDataSource+Delegate.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 25/07/2025.
//

import UIKit



final class CategoryDataSource: NSObject {
    var categories: [CategoryModel] = []
    var selectedIndex: Int = 0
    var onSelect: ((CategoryModel, Int) -> Void)?
}

extension CategoryDataSource: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        
        let category = categories[indexPath.item]
        let isSelected = indexPath.item == selectedIndex
        cell.configure(with: category.name, selected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        collectionView.reloadData() 
        
        let selectedCategory = categories[indexPath.item]
        onSelect?(selectedCategory, indexPath.item)
    }
}
