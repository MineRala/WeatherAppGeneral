//
//  Configuration.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 5.07.2021.
//

import Foundation
import UIKit

struct C {
    enum Font: String {
        case bold = "FuturaPT-Bold"
        case regular = "FuturaPT-Medium"
        case demiBold = "FuturaPT-Demi"
        case light = "FuturaPT-Light"
        
        func font(with size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size)!
        }
    }
    
    struct Color {
        static let cityInfoTitleColor =  #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1)
        static let titleDegreeColor =  #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1)
    }
}
