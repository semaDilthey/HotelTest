//
//  RoomsCell.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 15.12.2023.
//

import Foundation
import UIKit

final class RoomsCell : UITableViewCell {
    
    static let identifier = "RoomsCell"
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSpacingBetweenCells()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public var buttonTapped : (() -> Void)?
    
    public func set(model: RoomCellModelProtocol) {
        pagingCollectionView.imagesURL = model.imagesUrls
        name.text = model.name
        peculiarities.dataStorage = model.peculiarities.map{ " \($0) "}
        // по хорошему тоже надо писать методы для расчета всех якорей, но на это не хватит времени поэтому пока костыль
        if model.peculiarities.count > 2 && model.peculiarities.count < 5 {
            peculiarities.heightAnchor.constraint(equalToConstant: 50).isActive = true
        } else {
            peculiarities.heightAnchor.constraint(equalToConstant: 25).isActive = true
        }
        price.text = model.price + " ₽"
        pricePerLabel.text = model.pricePer
    }
    
    private let cardView : UIView = {
        let cardView = UIView()
        cardView.layer.cornerRadius = 12
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .white
        return cardView
    }()
    
    public let pagingCollectionView : PagingCollectionView = {
        let pagingCollectionView = PagingCollectionView()
        pagingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pagingCollectionView.isUserInteractionEnabled = true
        return pagingCollectionView
    }()
    
    private let name : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SD.proDisplayFont(size: 22, weight: .medium)
        label.numberOfLines = 0
        label.lineBreakStrategy = .standard
        return label
    }()
    
    private let peculiarities : TagViewCollectionView = {
        let label = TagViewCollectionView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var additionalInfoButton : UIButton = {
        let additionalInfoButton = UIButton()
        additionalInfoButton.setTitleColor(UIColor.SD.blue, for: .normal)
        additionalInfoButton.setTitle("Подробнее о номере", for: .normal)
        additionalInfoButton.titleLabel?.font = UIFont.SD.proDisplayFont(size: 16, weight: .medium)
        additionalInfoButton.titleEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 28)
        additionalInfoButton.backgroundColor = UIColor.SD.blueLight
        additionalInfoButton.translatesAutoresizingMaskIntoConstraints = false
        additionalInfoButton.layer.cornerRadius = 5
        return additionalInfoButton
    }()
    
    private let price : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SD.proDisplayFont(size: 30, weight: .bold)
        return label
    }()
    
    private let pricePerLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.SD.grey
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SD.proDisplayFont(size: 16, weight: .thin)
        return label
    }()
    
    private let chooseButton : BlueButton = {
        let chooseButton = BlueButton(title: "Выбрать номер")
        chooseButton.translatesAutoresizingMaskIntoConstraints = false
        chooseButton.clipsToBounds = true
        chooseButton.addTarget(self, action: #selector(chooseButtonPressed), for: .touchUpInside)
        return chooseButton
    }()
    
    
    private func addSpacingBetweenCells() {
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.backgroundColor = UIColor.SD.greyLight
    }
    
    @objc func chooseButtonPressed() {
        buttonTapped?()
    }
}

extension RoomsCell {
    
    private func setupUI() {
        contentView.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        cardView.addSubview(pagingCollectionView)
        NSLayoutConstraint.activate([
            pagingCollectionView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Constants.Sizes.bigGap),
            pagingCollectionView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.Sizes.leadingInset),
            pagingCollectionView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.Sizes.trailingInset),
            pagingCollectionView.heightAnchor.constraint(equalToConstant: 257)
        ])
        
        cardView.addSubview(name)
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: pagingCollectionView.bottomAnchor, constant: Constants.Sizes.smallGap),
            name.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.Sizes.leadingInset),
            name.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: Constants.Sizes.trailingInset)
        ])
        
        cardView.addSubview(peculiarities)
        NSLayoutConstraint.activate([
            peculiarities.topAnchor.constraint(equalTo: name.bottomAnchor, constant: Constants.Sizes.smallGap),
            peculiarities.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.Sizes.leadingInset),
            peculiarities.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: Constants.Sizes.trailingInset)
        ])
                
        cardView.addSubview(additionalInfoButton)
        NSLayoutConstraint.activate([
            additionalInfoButton.topAnchor.constraint(equalTo: peculiarities.bottomAnchor, constant: Constants.Sizes.smallGap),
            additionalInfoButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.Sizes.leadingInset),
            additionalInfoButton.widthAnchor.constraint(equalToConstant: 192)
        ])
        
        let priceAndPricePerLabel = UIStackView(arrangedSubviews: [price, pricePerLabel])
        priceAndPricePerLabel.spacing = 8
        priceAndPricePerLabel.axis = .horizontal
        priceAndPricePerLabel.alignment = .lastBaseline
        priceAndPricePerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.addSubview(priceAndPricePerLabel)
        NSLayoutConstraint.activate([
            priceAndPricePerLabel.topAnchor.constraint(equalTo: additionalInfoButton.bottomAnchor, constant: Constants.Sizes.bigGap),
            priceAndPricePerLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.Sizes.leadingInset)
        ])
        
        cardView.addSubview(chooseButton)
        NSLayoutConstraint.activate([
            chooseButton.topAnchor.constraint(equalTo: priceAndPricePerLabel.bottomAnchor, constant: Constants.Sizes.bigGap),
            chooseButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.Sizes.leadingInset),
            chooseButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.Sizes.trailingInset),
            chooseButton.heightAnchor.constraint(equalToConstant: 48)
        ])

    }
}
