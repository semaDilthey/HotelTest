//
//  PresentationCardView.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 15.12.2023.
//

import Foundation
import UIKit

class PresentationCardView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var hotel : Hotel? {
        didSet {
            DispatchQueue.main.async {
                self.setupCard(with: self.hotel)
            }
        }
    }
    
    private func setupCard(with hotel: Hotel?) {
        guard let hotel else { return }
        pagingCollectionView.imagesURL = hotel.imageUrls
        pagingCollectionView.collectionView.reloadData()
        ratingLabel.rating.text = String(hotel.rating) + " " + hotel.ratingName
        hotelName.text = hotel.name
        location.text = hotel.adress
        price.text = "от " + String(hotel.minimalPrice) + " ₽"
        pricePerLabel.text = hotel.priceForIt.lowercased()
    }
    
    let cardView : UIView = {
        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = UIColor.SD.orangeLight
        cardView.layer.cornerRadius = 15
        cardView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return cardView
    }()

    
    let pagingCollectionView : PagingCollectionView = {
        let pagingCollectionView = PagingCollectionView()
        pagingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pagingCollectionView.isUserInteractionEnabled = true
        return pagingCollectionView
    }()
    
    let ratingLabel : RatingLabel = {
        let label = RatingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.SD.orangeLight
        return label
    }()
    
    let hotelName : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SD.proDisplayFont(size: 22, weight: .medium)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let location : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.SD.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SD.proDisplayFont(size: 14, weight: .medium)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let price : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SD.proDisplayFont(size: 30, weight: .bold)
        return label
    }()
    
    let pricePerLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.SD.grey
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SD.proDisplayFont(size: 16, weight: .thin)
        return label
    }()
}


extension PresentationCardView {
    private func setupUI() {
        cardView.backgroundColor = .white
        
        addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        cardView.addSubview(pagingCollectionView)
        NSLayoutConstraint.activate([
            pagingCollectionView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.Sizes.leadingInset),
            pagingCollectionView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.Sizes.trailingInset),
            pagingCollectionView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 1),
            pagingCollectionView.heightAnchor.constraint(equalToConstant: 257)
        ])
        
        cardView.addSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.Sizes.leadingInset),
            ratingLabel.topAnchor.constraint(equalTo: pagingCollectionView.bottomAnchor, constant: Constants.Sizes.bigGap),
            ratingLabel.widthAnchor.constraint(equalToConstant: 160)
        ])
        
        let ratingNameLocationStack = UIStackView(arrangedSubviews:  [hotelName, location])
        ratingNameLocationStack.axis = .vertical
        ratingNameLocationStack.translatesAutoresizingMaskIntoConstraints = false
        ratingNameLocationStack.spacing = 8
        ratingNameLocationStack.alignment = .leading
        
        cardView.addSubview(ratingNameLocationStack)
        ratingNameLocationStack.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: Constants.Sizes.smallGap).isActive = true
        ratingNameLocationStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.Sizes.leadingInset).isActive = true
        ratingNameLocationStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.Sizes.trailingInset).isActive = true
        
        let priceAndPricePerStack = UIStackView(arrangedSubviews: [price, pricePerLabel])
        priceAndPricePerStack.axis = .horizontal
        priceAndPricePerStack.translatesAutoresizingMaskIntoConstraints = false
        priceAndPricePerStack.spacing = 8
        priceAndPricePerStack.alignment = .lastBaseline
        
        cardView.addSubview(priceAndPricePerStack)
        priceAndPricePerStack.topAnchor.constraint(equalTo: ratingNameLocationStack.bottomAnchor, constant: Constants.Sizes.bigGap).isActive = true
        priceAndPricePerStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.Sizes.leadingInset).isActive = true

    }
}
