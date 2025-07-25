//
//  MainTabBarController.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit


final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        tabBar.tintColor = .systemRed
        tabBar.backgroundColor = .white
    }

    private func setupTabs() {
        let menuVC = HomeBuilder.build()
        menuVC.tabBarItem = UITabBarItem(title: "Меню", image: UIImage(systemName: "list.bullet"), tag: 0)

        let contactsVC = ContactBuilder.build()
        contactsVC.tabBarItem = UITabBarItem(title: "Контакты", image: UIImage(systemName: "phone"), tag: 1)

        let profileVC = ProfileBuilder.build()
        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.crop.circle"), tag: 2)

        let cartVC = CartBuilder.build()
        cartVC.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart"), tag: 3)

        viewControllers = [
            UINavigationController(rootViewController: menuVC),
            UINavigationController(rootViewController: contactsVC),
            UINavigationController(rootViewController: profileVC),
            UINavigationController(rootViewController: cartVC)
        ]
    }
}
