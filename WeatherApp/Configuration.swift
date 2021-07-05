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
        case book = "FuturaPT-Book"
        
        func font(with size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size)!
        }
    }
    
    struct Color {
        static let cityInfoTitleColor =  #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1)
        static let labelDegreeColor = #colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
        static let labelTimeColor = #colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
        static let imageIconColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        static let lblTitleColor = #colorLiteral(red: 0.5764705882, green: 0.5764705882, blue: 0.5764705882, alpha: 1)
        static let lblValueColor = #colorLiteral(red: 0.4745098039, green: 0.4745098039, blue: 0.4745098039, alpha: 1)
        static let nextDaysColor = #colorLiteral(red: 0.3607843137, green: 0.3607843137, blue: 0.3607843137, alpha: 1)
        static let labelDegreeInfoColor = #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1)
        static let labelDcColor = #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1)
        static let labelStateColor = #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1)
        static let imageIconInfo = #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1)
      
    }
}
