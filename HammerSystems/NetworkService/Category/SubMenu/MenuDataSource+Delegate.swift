//
//  MenuDataSource+Delegate.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 25/07/2025.
//

import UIKit


final class DishDataSource: NSObject {
    var dishesByCategory: [[Dish]] = []
    var categories: [CategoryModel] = []
    var sectionScrollHandler: ((Int) -> Void)?
    weak var homeViewController: HomeViewController?
}

extension DishDataSource: UITableViewDataSource, UITableViewDelegate {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return dishesByCategory.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishesByCategory[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DishCell", for: indexPath) as? DishCell else {
            return UITableViewCell()
        }
        
        let dish = dishesByCategory[indexPath.section][indexPath.row]
        cell.configure(with: dish)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].name
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tableView = scrollView as? UITableView else { return }
            
            let contentOffset = tableView.contentOffset.y
            let lastOffset = (homeViewController?.lastContentOffset ?? 0)
            
            if abs(contentOffset - lastOffset) > 5 ||
               contentOffset <= 0 ||
               contentOffset >= tableView.contentSize.height - tableView.frame.height {
                
                if let visibleIndex = tableView.indexPathsForVisibleRows?.first?.section {
                    sectionScrollHandler?(visibleIndex)
                }
                
                homeViewController?.updateStickyCategories(offset: contentOffset)
                homeViewController?.lastContentOffset = contentOffset
            }
    }
}

