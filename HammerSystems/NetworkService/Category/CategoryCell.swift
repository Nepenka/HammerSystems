//
//  CategoryCell.swift
//  HammerSystems
//
//  Created by Владислав Перелыгин on 25/07/2025.
//

import UIKit
import SnapKit

final class CategoryCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.backgroundColor = .white
        
        contentView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }

    func configure(with title: String, selected: Bool) {
        titleLabel.text = title
        contentView.backgroundColor = selected ? UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 1.0)  : .white
        titleLabel.textColor = selected ? .red : UIColor.red.withAlphaComponent(0.3)
        titleLabel.font = selected ? .systemFont(ofSize: 14, weight: .bold) : .systemFont(ofSize: 14, weight: .medium)
        contentView.layer.borderColor = selected ? UIColor.clear.cgColor : UIColor.red.withAlphaComponent(0.5).cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
