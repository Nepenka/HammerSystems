//
//  ProfileViewController.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit
import SnapKit


final class ProfileViewController: UIViewController, ProfileViewProtocol {
    weak var viewController: UIViewController?
    var presenter: ProfilePresenterProtocol?
    
    private let exitButton: UIButton = {
       let button = UIButton()
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        view.backgroundColor = .white
        view.addSubview(exitButton)
        exitButton.snp.makeConstraints { exit in
            exit.centerX.equalToSuperview()
            exit.centerY.equalToSuperview()
        }
        exitButton.addTarget(self, action: #selector(exitAction), for: .touchUpInside)
    }
    
    @objc func exitAction() {
        AuthStorage.logout()

            guard let scene = view.window?.windowScene,
                  let sceneDelegate = scene.delegate as? SceneDelegate,
                  let window = sceneDelegate.window else { return }
            
            let authVC = AuthModuleBuilder.build()
        
            UIView.transition(with: window, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
                window.rootViewController = authVC
            })
    }
}

final class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewProtocol?
    var router: ProfileRouterProtocol?
}

final class ProfileRouter: ProfileRouterProtocol {
    weak var viewController: UIViewController?
}
