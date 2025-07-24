//
//  SplashPresenter.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit



final class SplashPresenter: SplashPresenterProtocol {
    weak var view: SplashViewProtocol?
    var router: SplashRouterProtocol?
    
    
    func viewDidLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.router?.showAuthScreen()
        }
    }
}
