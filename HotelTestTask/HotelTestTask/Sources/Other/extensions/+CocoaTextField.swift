//
//  +CocoaTextField.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 07.01.2024.
//

import Foundation
import CocoaTextField
import UIKit

extension CocoaTextField {
    
    static func create(placeholder: String) -> CocoaTextField {
        let phoneTextField = CocoaTextField()
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.borderColor = .clear
        phoneTextField.defaultBackgroundColor = UIColor.SD.greyLight!
        phoneTextField.focusedBackgroundColor = UIColor.SD.greyLight!
        phoneTextField.placeholder = placeholder
        phoneTextField.font = UIFont.SD.proDisplayFont(size: 16, weight: .thin)
        phoneTextField.activeHintColor = UIColor.SD.grey!
        return phoneTextField
    }
}
