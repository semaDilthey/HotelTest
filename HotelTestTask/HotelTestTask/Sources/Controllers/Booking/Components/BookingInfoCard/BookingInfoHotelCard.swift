//
//  HotelInfoChildView.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 18.12.2023.
//

import Foundation
import UIKit

class BookingInfoHotelCard: UIView {
    
    var viewModel: BookingViewModel? {
        didSet {
            configure(with: viewModel)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = .white
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: BookingViewModel?) {
        guard let booking = viewModel?.bookingData else { return }
        DispatchQueue.main.async { [self] in
            rating.rating.text = String(booking.horating) + " " + booking.ratingName
            hotelName.text = booking.hotelName
            location.text = booking.hotelAdress
        }
    }
    
    let rating = RatingLabel()
    
    let hotelName : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SD.proDisplayFont(size: 22, weight: .medium)
        label.numberOfLines = 0
        label.lineBreakStrategy = .standard
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
}

//MARK: - SetupUI
extension BookingInfoHotelCard {
    private func setupUI() {
        addSubview(rating)
        rating.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rating.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Sizes.leadingInset),
            rating.topAnchor.constraint(equalTo: topAnchor, constant: Constants.Sizes.bigGap),
            rating.widthAnchor.constraint(equalToConstant: 160)
        ])
        
        let ratingNameLocationStack = UIStackView(arrangedSubviews:  [hotelName, location])
        ratingNameLocationStack.axis = .vertical
        ratingNameLocationStack.translatesAutoresizingMaskIntoConstraints = false
        ratingNameLocationStack.spacing = 8
        ratingNameLocationStack.alignment = .leading
        
        addSubview(ratingNameLocationStack)
        ratingNameLocationStack.topAnchor.constraint(equalTo: rating.bottomAnchor, constant: Constants.Sizes.smallGap).isActive = true
        ratingNameLocationStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Sizes.leadingInset).isActive = true
        ratingNameLocationStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Sizes.trailingInset).isActive = true
    }
}
