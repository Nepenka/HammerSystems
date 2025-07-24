//
//  SplashViewController.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit
import SnapKit


class SplashViewController: UIViewController, SplashViewProtocol {
    
    var presenter: SplashPresenterProtocol?
    
    private let logoImageView: UIImageView = {
       let logo = UIImageView()
        logo.image = UIImage(named: "SplashLogo")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1, green: 0.2, blue: 0.5, alpha: 1)
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { logo in
            logo.center.equalToSuperview()
            logo.width.equalTo(350)
            logo.height.equalTo(350)
        }
        
        presenter?.viewDidLoad()
    }
   
}
