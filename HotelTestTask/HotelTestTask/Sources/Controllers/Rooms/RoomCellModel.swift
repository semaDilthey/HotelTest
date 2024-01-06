//
//  RoomCellModel.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 17.12.2023.
//

import Foundation
import UIKit

protocol RoomCellModelProtocol {
    var id : Int { get set }
    var name : String { get set }
    var peculiarities : [String] { get set }
    var price : String { get set }
    var pricePer : String { get set }
    var imagesUrls : [String] { get set }
}

struct RoomCellModel : RoomCellModelProtocol {
    var id : Int
    
    var name: String
    var peculiarities: [String]
    var price: String
    var pricePer: String
    var imagesUrls: [String]
    
}
