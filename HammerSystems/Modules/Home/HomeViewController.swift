//
//  HomeViewController.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 24/07/2025.
//

import Foundation
import UIKit
import SnapKit



final class HomeViewController: UIViewController, HomeViewProtocol {
   
    var presenter: HomePresenterProtocol?
    var shouldShowLoginSuccessBanner: Bool = false
    private var banners: [Banner] = []
    private var currentIndex = 0
    private var timer: Timer?
    private let categoryDataSource = CategoryDataSource()
    
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Москва ▼"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 180)
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.cornerRadius = 15
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(width: 100, height: 40)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        if shouldShowLoginSuccessBanner {
            showAuthBanner(
                message: "Вход выполнен успешно",
                iconName: "checkmark.circle.fill",
                color: .systemGreen
            )
        }
        setupUI()
        banners = presenter?.getBanners() ?? []
        bannerCollectionView.reloadData()
        startAutoScroll()
        categoryCollectionView.dataSource = categoryDataSource
        categoryCollectionView.delegate = categoryDataSource
    }
    
    private func setupUI() {
        view.addSubview(cityLabel)
        view.addSubview(bannerCollectionView)
        view.addSubview(categoryCollectionView)

        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.left.equalToSuperview().offset(16)
        }
        
        bannerCollectionView.snp.makeConstraints { banner in
            banner.top.equalTo(cityLabel.snp.bottom).offset(25)
            banner.leading.trailing.equalToSuperview()
            banner.height.equalTo(180)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(bannerCollectionView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCity))
        cityLabel.addGestureRecognizer(tapGesture)
    }

    @objc private func didTapCity() {
        presenter?.didTapCitySelection()
    }

    func updateCity(name: String) {
        cityLabel.text = "\(name) ▼"
    }
    
    func reloadCategories() {
        categoryDataSource.categories = presenter?.getCategories() ?? []
        categoryDataSource.selectedIndex = presenter?.getSelectedCategoryIndex() ?? 0
        categoryCollectionView.reloadData()
    }

    
    private func startAutoScroll() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            guard let self = self, !self.banners.isEmpty else { return }
            
            self.currentIndex = (self.currentIndex + 1) % self.banners.count
            let indexPath = IndexPath(item: self.currentIndex, section: 0)
            self.bannerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }

    deinit {
        timer?.invalidate()
    }
    
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as? BannerCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: banners[indexPath.item])
        return cell
    }
}
