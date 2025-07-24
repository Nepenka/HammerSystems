//
//  UITextField + Extension.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit
import Foundation

extension UITextField {
    func setLeftIcon(named systemName: String) {
        let imageView = UIImageView(image: UIImage(systemName: systemName))
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 24))
        container.addSubview(imageView)
        imageView.center = container.center
        
        self.leftView = container
        self.leftViewMode = .always
        
    }
}
