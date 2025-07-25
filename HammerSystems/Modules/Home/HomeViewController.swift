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
    private let dishDataSource = DishDataSource()
    private let stickyCategoriesContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    private var stickyCategoriesTopConstraint: Constraint?
    private var originalCategoriesFrame: CGRect = .zero
    var lastContentOffset: CGFloat = 0
   
    
    
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
        collectionView.backgroundColor = .white
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
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DishCell.self, forCellReuseIdentifier: "DishCell")
        tableView.backgroundView = UIView()
        
        tableView.backgroundView?.backgroundColor = .white
        return tableView
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
        tableView.dataSource = dishDataSource
        tableView.delegate = dishDataSource
        categoryDataSource.presenter = presenter as? HomePresenter
        categoryDataSource.tableView = tableView
        categoryDataSource.dishDataSource = dishDataSource
        dishDataSource.homeViewController = self
    }
    
    private func setupUI() {
        view.addSubview(cityLabel)
        view.addSubview(bannerCollectionView)
        view.addSubview(categoryCollectionView)
        view.addSubview(tableView)
        view.addSubview(stickyCategoriesContainer)

        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.left.equalToSuperview().offset(16)
        }
        
        bannerCollectionView.snp.makeConstraints { banner in
            banner.top.equalTo(cityLabel.snp.bottom).offset(25)
            banner.leading.trailing.equalToSuperview()
            banner.height.equalTo(180)
        }
        
        categoryCollectionView.snp.makeConstraints { category in
            category.top.equalTo(bannerCollectionView.snp.bottom).offset(20).priority(.high)
            category.leading.trailing.equalToSuperview().inset(20)
            category.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { table in
            table.top.equalTo(categoryCollectionView.snp.bottom).offset(12)
            table.leading.trailing.bottom.equalToSuperview()
        }
        
        stickyCategoriesContainer.snp.makeConstraints { sticky in
            sticky.leading.trailing.equalToSuperview()
            sticky.height.equalTo(50).priority(.high)
            self.stickyCategoriesTopConstraint = sticky.top.equalTo(view.safeAreaLayoutGuide).constraint
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
    
        func updateStickyCategories(offset: CGFloat) {
        let threshold = bannerCollectionView.frame.maxY - view.safeAreaInsets.top
            
            guard offset > 0 else{
                stickyCategoriesContainer.isHidden = true
                return
            }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: [.allowUserInteraction, .curveEaseInOut], animations: {
            if offset >= threshold {
                self.stickyCategoriesContainer.isHidden = false
                self.stickyCategoriesTopConstraint?.update(offset: 0)
                
                if self.categoryCollectionView.superview != self.stickyCategoriesContainer {
                    self.originalCategoriesFrame = self.categoryCollectionView.frame
                    self.stickyCategoriesContainer.addSubview(self.categoryCollectionView)
                    self.categoryCollectionView.snp.remakeConstraints {
                        $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
                    }
                    self.view.layoutIfNeeded()
                }
            } else {
                self.stickyCategoriesContainer.isHidden = true
                
                if self.categoryCollectionView.superview != self.view {
                    self.view.addSubview(self.categoryCollectionView)
                    self.categoryCollectionView.snp.remakeConstraints {
                        $0.top.equalTo(self.bannerCollectionView.snp.bottom).offset(20)
                        $0.leading.trailing.equalToSuperview().inset(20)
                        $0.height.equalTo(50)
                    }
                    self.view.layoutIfNeeded()
                }
            }
        })
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
