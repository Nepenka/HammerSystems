//
//  UIViewController.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit



extension UIViewController {
    //MARK: - Работа с клавиатурой
    func setupKeyboardDismissRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - Уведомление о правильном входе
    func showAuthBanner(message: String, iconName: String, color: UIColor) {
        let banner = AuthAlertBanner(message: message, iconName: iconName, backgroundColor: color)
        view.addSubview(banner)
        
        banner.snp.makeConstraints { baner in
            baner.top.equalTo(view.safeAreaLayoutGuide).offset(-60)
            baner.centerX.equalToSuperview()
            baner.height.equalTo(50)
            baner.right.left.equalToSuperview().inset(25)
        }
        
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5) {
            banner.transform = CGAffineTransform(translationX: 0, y: 70)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseIn], animations: {
                banner.alpha = 0
                banner.transform = CGAffineTransform(translationX: 0, y: 10)
            }) { _ in
                banner.removeFromSuperview()
            }
        }
    }
}
