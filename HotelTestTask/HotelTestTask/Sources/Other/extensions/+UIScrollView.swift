//
//  +UIScrollView.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 05.01.2024.
//

import Foundation
import UIKit

extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top - 98)
        setContentOffset(desiredOffset, animated: true)
   }
}
