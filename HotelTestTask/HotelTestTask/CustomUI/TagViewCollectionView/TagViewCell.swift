//
//  TagViewCell.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 16.12.2023.
//

import Foundation
import UIKit

class TagViewCell: UICollectionViewCell {

    static let identifier = "TagViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        layer.cornerRadius = 3
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(text: String) {
        label.text = text
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.SD.greyLight
        label.textColor = UIColor.SD.grey
        label.font = UIFont.SD.proDisplayFont(size: 16, weight: .medium)
        return label
    }()

    private func setupViews() {
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

