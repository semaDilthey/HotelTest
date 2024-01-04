//
//  +UIFont.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 18.12.2023.
//

import Foundation
import UIKit

extension UIFont {
    struct SD {
        enum SFProDisplayFont: Int {
                case thin = 400
                case medium = 500
                case bold = 600
                
                var nameFont: String {
                    switch self {
                    case .thin:
                        return "SF Pro Display Thin"
                    case .medium:
                        return "SF Pro Display Medium"
                    case .bold:
                        return "SF Pro Display Semibold"
                    }
                }
            }
            
            static func proDisplayFont(size fontSize: CGFloat, weight fontWeight: SFProDisplayFont) -> UIFont? {
                UIFont(name: fontWeight.nameFont, size: fontSize)
            }
    }
}
