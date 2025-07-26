//
//  MainTabBarController.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit


final class MainTabBarController: UITabBarController {
    
    private let showLoginSuccessBanner: Bool
    
    init(showLoginSuccessBanner: Bool = false) {
        self.showLoginSuccessBanner = showLoginSuccessBanner
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        tabBar.tintColor = .systemRed
        tabBar.backgroundColor = .white
    }

    private func setupTabs() {
        let menuVC = HomeBuilder.build(showLoginSuccessBanner: showLoginSuccessBanner)
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
