//
//  Validator.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 29.12.2023.
//

import Foundation
import CocoaTextField
import UIKit

enum Validator {
    
    static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func checkFullfillment(in textFields: [CocoaTextField]) {
        for field in textFields {
            if field.text == "" {
                field.borderColor = .red
                UISelectionFeedbackGenerator().selectionChanged()
            }
        }
        
    }
    
}
