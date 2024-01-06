//
//  RatingLabel.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 15.12.2023.
//

import Foundation
import UIKit

class RatingLabel : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = UIColor.SD.orangeLight
        layer.cornerRadius = 5
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let rootView : UIView = {
        let rootView = UIView()
        rootView.translatesAutoresizingMaskIntoConstraints = false
        return rootView
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = UIColor.SD.orange
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let rating : UILabel = {
        let rating = UILabel()
        rating.text = "Rating"
        rating.textColor = UIColor.SD.orange
        rating.translatesAutoresizingMaskIntoConstraints = false
        return rating
    }()
    
    func setupUI() {
        backgroundColor = UIColor.SD.orangeLight
        addSubview(rootView)
        NSLayoutConstraint.activate([
            rootView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rootView.topAnchor.constraint(equalTo: topAnchor),
            rootView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    
        rootView.addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: 10).isActive = true
        imageView.topAnchor.constraint(equalTo: rootView.topAnchor, constant: 7).isActive = true
        imageView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -7).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true

        
        rootView.addSubview(rating)
        rating.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 3).isActive = true
        rating.topAnchor.constraint(equalTo: rootView.topAnchor, constant: 5).isActive = true
        rating.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -5).isActive = true
    }
}
