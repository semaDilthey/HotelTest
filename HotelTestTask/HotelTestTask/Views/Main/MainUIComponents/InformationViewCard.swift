//
//  InformationViewCard.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 16.12.2023.
//

import Foundation
import UIKit

class InformationViewCard : UIView {
    
    var hotel : Hotel? {
        didSet {
            guard let hotel else { return }
            DispatchQueue.main.async {
                self.aboutHotelInformation.text = hotel.aboutTheHotel.description
                self.tagsCollection.dataStorage = hotel.aboutTheHotel.peculiarities.map{ " \($0) "}
                self.tagsCollection.reloadData()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cardView : UIView = {
        let cardView = UIView()
        cardView.layer.cornerRadius = 15
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }()
    
    let aboutHotelLabel : UILabel = {
        let aboutLabel = UILabel()
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.text = "Об отеле"
        aboutLabel.font = UIFont.SD.proDisplayFont(size: 22, weight: .medium)
        return aboutLabel
    }()
    
    lazy var tagsCollection : TagViewCollectionView = {
        let tagsCollection = TagViewCollectionView()
        tagsCollection.translatesAutoresizingMaskIntoConstraints = false
        tagsCollection.clipsToBounds = true
        return tagsCollection
    }()
    
    let aboutHotelInformation : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SD.proDisplayFont(size: 16, weight: .thin)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
}


extension InformationViewCard {
    private func setupUI() {
        cardView.backgroundColor = .white
        
        addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        cardView.addSubview(aboutHotelLabel)
        NSLayoutConstraint.activate([
            aboutHotelLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.Sizes.leadingInset),
            aboutHotelLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Constants.Sizes.bigGap)
        ])
        
        cardView.addSubview(tagsCollection)
        NSLayoutConstraint.activate([
            tagsCollection.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.Sizes.leadingInset),
            tagsCollection.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.Sizes.trailingInset),
            tagsCollection.topAnchor.constraint(equalTo: aboutHotelLabel.bottomAnchor, constant: Constants.Sizes.bigGap),
            tagsCollection.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        cardView.addSubview(aboutHotelInformation)
        NSLayoutConstraint.activate([
            aboutHotelInformation.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.Sizes.leadingInset),
            aboutHotelInformation.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.Sizes.trailingInset),
            aboutHotelInformation.topAnchor.constraint(equalTo: tagsCollection.bottomAnchor, constant: Constants.Sizes.bigGap * 0.75),
            aboutHotelInformation.heightAnchor.constraint(equalToConstant: 76)
        ])

    }
}
