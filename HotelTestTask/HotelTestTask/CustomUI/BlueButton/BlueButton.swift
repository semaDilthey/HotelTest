//
//  BlueButton.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 15.12.2023.
//

import Foundation
import UIKit

class BlueButton : UIButton {
    
    var title : String? {
        didSet {
            DispatchQueue.main.async {
                self.setTitle(self.title, for: .normal)
            }
        }
    }
    
    init(title: String) {
        super.init(frame: constantFrame)
        setupButton(title: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var constantFrame = CGRect(x: 0, y: 0, width: 343, height: 48)
    
    private func setupButton(title: String) {
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor.SD.blue
        layer.cornerRadius = 15
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.SD.proDisplayFont(size: 16, weight: .medium)
    }
    
}
