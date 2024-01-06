//
//  MainTableModel.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 05.01.2024.
//

import Foundation
import UIKit

protocol MainTableModelProtocol {
    var image : UIImage { get }
    var article : String { get }
    var properties : String { get }
}

struct MainTableModel : MainTableModelProtocol {
    var image: UIImage
    var article: String
    var properties: String
}
