//
//  HomeViewController.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import UIKit
import SnapKit



final class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationItem.hidesBackButton = true
    }
    
}
