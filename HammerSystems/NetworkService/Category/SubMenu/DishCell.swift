//
//  DishCell.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 25/07/2025.
//

import UIKit
import SnapKit
import AlamofireImage

final class DishCell: UITableViewCell {
    
    private let dishImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.backgroundColor = .lightGray.withAlphaComponent(0.1)
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let description = UILabel()
        description.font = .systemFont(ofSize: 14)
        description.textColor = .gray
        description.numberOfLines = 0
        return description
    }()
    
    private let priceLabel: UILabel = {
        let price = UILabel()
        price.font = .boldSystemFont(ofSize: 16)
        price.textColor = .red
        return price
    }()
    
    private let infoStack: UIStackView = {
        let info = UIStackView()
        info.axis = .vertical
        info.spacing = 8
        info.distribution = .fill
        info.backgroundColor = .white
        return info
    }()
    
    private let contentStack: UIStackView = {
        let content = UIStackView()
        content.axis = .horizontal
        content.spacing = 16
        content.alignment = .top
        content.backgroundColor = .white
        return content
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        selectionStyle = .none
        self.backgroundColor = .white
        self.contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(contentStack)
        
        contentStack.addArrangedSubview(dishImageView)
        contentStack.addArrangedSubview(infoStack)
        
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(descriptionLabel)
        infoStack.addArrangedSubview(priceLabel)
        
        dishImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
        }
        
        contentStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    func configure(with dish: Dish) {
        nameLabel.text = dish.name
        descriptionLabel.text = dish.content
        priceLabel.text = "от \(dish.price) ₽"
        
        let baseURL = "https://vkus-sovet.ru"  
        
        let fullImageUrlString = baseURL + dish.image
        if let imageUrl = URL(string: fullImageUrlString) {
            let placeholderImage = UIImage(named: "placeholder")
            dishImageView.af.setImage(
                withURL: imageUrl,
                placeholderImage: placeholderImage,
                imageTransition: .crossDissolve(0.3),
                completion: { response in
                    if let error = response.error {
                        print("Ошибка загрузки картинки: \(error.localizedDescription)")
                    }
                }
            )
        } else {
            dishImageView.image = UIImage(named: "placeholder")
        }
    }

}
