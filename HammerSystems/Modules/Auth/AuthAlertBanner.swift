//
//  AuthAlertBanner.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit
import SnapKit



class AuthAlertBanner: UIView {
    private let iconImageView = UIImageView()
    private let messageLabel = UILabel()
    
    init(message: String, iconName: String, backgroundColor: UIColor) {
            super.init(frame: .zero)
            setupUI(message: message, iconName: iconName, bgColor: backgroundColor)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI(message: String, iconName: String, bgColor: UIColor) {
            backgroundColor = bgColor
            layer.cornerRadius = 12
            clipsToBounds = true
            
            iconImageView.image = UIImage(systemName: iconName)
            iconImageView.tintColor = .white
            
            messageLabel.text = message
            messageLabel.textColor = .white
            messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            
            addSubview(iconImageView)
            addSubview(messageLabel)
            
            iconImageView.snp.makeConstraints { icon in
                icon.right.equalToSuperview().inset(16)
                icon.centerY.equalToSuperview()
                icon.size.equalTo(24)
            }
            
            messageLabel.snp.makeConstraints { message in
                message.center.equalToSuperview().inset(12)
                message.trailing.equalToSuperview().inset(16)
                message.centerY.equalToSuperview()
            }
        }
}
