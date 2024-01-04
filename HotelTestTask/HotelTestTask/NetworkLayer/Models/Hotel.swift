//
//  Hotel.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 15.12.2023.
//

import Foundation

struct Hotel : Decodable {
    let id : Int
    let name : String
    let adress : String
    let minimalPrice : Int
    let priceForIt : String
    let rating : Int
    let ratingName : String
    let imageUrls : [String]
    let aboutTheHotel : AboutTheHotel
    
}

struct AboutTheHotel : Decodable {
    let description: String
    let peculiarities: [String]
}
