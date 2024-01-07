//
//  PaidViewModel.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 05.01.2024.
//

import Foundation
import UIKit

final class PaidViewModel : BaseViewModel {
    
    var bookingNumber : Int?

    init(bookingNumber : Int, coordinator: Coordinator?) {
        self.bookingNumber = bookingNumber
        super.init(coordinator: coordinator)
    }
        
    func configure(label: UILabel) {
        guard let bookingNumber else { return }
        label.text = "Подтвеждение заказа №\(String(describing: bookingNumber)) может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора вам на почту придет уведомление"
    }
}
