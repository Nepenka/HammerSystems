//
//  AuthViewController.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit
import SnapKit


import UIKit
import SnapKit

final class AuthViewController: UIViewController, AuthViewProtocol {
    
    
    // MARK: - Properties
    private var enterButtonBottomConstraint: Constraint?
    var presenter:  AuthPresenterProtocol?

    private let logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "AuthLogo")
        logo.contentMode = .scaleAspectFit
        return logo
    }()

    private let passwordToggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.tintColor = .gray
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.isHidden = true
        return button
    }()

    private let nameTextField: UITextField = {
        let nameField = UITextField()
        nameField.layer.borderWidth = 1.0
        nameField.layer.cornerRadius = 15
        nameField.textColor = .black
        nameField.layer.borderColor = UIColor.gray.cgColor
        nameField.attributedPlaceholder = NSAttributedString(
            string: "Логин",
            attributes: [.foregroundColor: UIColor.gray]
        )
        nameField.setLeftIcon(named: "person.fill")
        return nameField
    }()

    private let passwordTextField: UITextField = {
        let passwordField = UITextField()
        passwordField.layer.borderWidth = 1.0
        passwordField.layer.borderColor = UIColor.gray.cgColor
        passwordField.layer.cornerRadius = 15
        passwordField.textColor = .black
        passwordField.attributedPlaceholder = NSAttributedString(
            string: "Пароль",
            attributes: [.foregroundColor: UIColor.gray]
        )
        passwordField.setLeftIcon(named: "lock.fill")
        return passwordField
    }()

    private let enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(red: 1, green: 0.2, blue: 0.5, alpha: 1)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "Авторизация"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]

        setupKeyboardDismissRecognizer()
        setupActions()

        [logoImage, nameTextField, passwordTextField, enterButton].forEach { view.addSubview($0) }

        passwordTextField.rightView = passwordToggleButton
        passwordTextField.rightViewMode = .always
        passwordTextField.isSecureTextEntry = true

        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Setup
    private func setupActions() {
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        passwordTextField.addTarget(self, action: #selector(passwordFieldDidChange), for: .editingChanged)
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
    }

    private func setupConstraints() {
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(50)
            make.width.equalTo(200)
            make.height.equalTo(125)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(50)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(nameTextField)
            make.height.equalTo(50)
        }

        enterButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(passwordTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(nameTextField)
            make.height.equalTo(50)
            self.enterButtonBottomConstraint = make.bottom.equalToSuperview().inset(40).constraint
        }
    }

    // MARK: - AuthViewProtocol
    func showBanner(message: String, iconName: String, color: UIColor) {
        showAuthBanner(message: message, iconName: iconName, color: color)
    }

    // MARK: - Actions
    @objc private func enterButtonTapped() {
        presenter?.login(username: nameTextField.text, password: passwordTextField.text)
    }

    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()

        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        passwordToggleButton.setImage(UIImage(systemName: imageName), for: .normal)

        let currentText = passwordTextField.text
        passwordTextField.text = ""
        passwordTextField.text = currentText
    }

    @objc private func passwordFieldDidChange() {
        passwordToggleButton.isHidden = passwordTextField.text?.isEmpty ?? true
    }

    // MARK: - Keyboard Handling
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }

        enterButtonBottomConstraint?.update(inset: keyboardFrame.height + 10)

        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }

        enterButtonBottomConstraint?.update(inset: 40)

        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}
