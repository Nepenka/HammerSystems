//
//  AuthPresenter.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit




final class AuthPresenter: AuthPresenterProtocol {
    weak var view: AuthViewProtocol?
    var router: AuthRouterProtocol?
    
    func login(username: String?, password: String?) {
        
        if username == "Qwerty123" && password == "Qwerty123" {
            router?.showHomeScreen()
        } else {
            view?.showBanner(
                message: "Неправильный логин или пароль",
                iconName: "xmark.circle.fill",
                color: .systemRed
            )
        }
    }
}
