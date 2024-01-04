//
//  BookingHotelInfoCard.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 18.12.2023.
//

import Foundation
import UIKit

class BookingInfoCard : UIView {

    var viewModel: BookingViewModel? {
        didSet {
            hotelInfoView.viewModel = viewModel
            bookingInfoView.viewModel = viewModel
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let hotelInfoView = BookingInfoHotelCard()
    let bookingInfoView = BookingInfoBookingCard() 
    
    private func setupUI() {
        addSubview(hotelInfoView)
        hotelInfoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hotelInfoView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.Sizes.smallGap),
            hotelInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            hotelInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            hotelInfoView.heightAnchor.constraint(equalToConstant: 145)
        ])
        
        addSubview(bookingInfoView)
        bookingInfoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookingInfoView.topAnchor.constraint(equalTo: hotelInfoView.bottomAnchor, constant: Constants.Sizes.smallGap),
            bookingInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            bookingInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            bookingInfoView.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
    
}
