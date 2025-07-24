//
//  AuthViewController.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit



final class AuthViewController: UIViewController, AuthViewProtocol {
    
    var presenter: AuthPresenterProtocol?
    
    private let logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "AuthLogo")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    private let nameTextField: UITextField = {
       let nameField = UITextField()
        nameField.layer.borderWidth = 1.0
        nameField.layer.cornerRadius = 2.0
        nameField.layer.borderColor = UIColor.gray.cgColor
        nameField.placeholder = "Логин"
        nameField.leftView = UIImageView(image: UIImage(systemName: "person.fill"))
        return nameField
    }()
    
    private let passwordTextField: UITextField = {
       let passwordField = UITextField()
        passwordField.layer.borderWidth = 1.0
        passwordField.layer.borderColor = UIColor.gray.cgColor
        passwordField.layer.cornerRadius = 2.0
        passwordField.placeholder = "Пароль"
        passwordField.leftView = UIImageView(image: UIImage(systemName: "lock.fill"))
        return passwordField
    }()
    
    private let enterButton: UIButton = {
       let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 2.0
        button.backgroundColor = UIColor(red: 1, green: 0.2, blue: 0.5, alpha: 1)
        
        return button
    }()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            [nameTextField, passwordTextField, logoImage, enterButton].forEach {view.addSubview($0)}
            
            
        }

}
