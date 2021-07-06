//
//  Configuration.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 5.07.2021.
//

import Foundation
import UIKit

struct C {
    struct App {
        static let numberOfItemsInHourlyCollectionView: Int = 8
    }
    
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
        static var viewControllerBackgroundColor: UIColor { UITraitCollection.current.userInterfaceStyle == .light ?  #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1) : #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1) }
        static var cityInfoTitleColor =   #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1)
        static var labelDegreeColor = #colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
        static var labelTimeColor = #colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
        static var imageIconColor = #colorLiteral(red: 0.4862745098, green: 0.4823529412, blue: 0.4823529412, alpha: 1)
        static var lblTitleColor = #colorLiteral(red: 0.5764705882, green: 0.5764705882, blue: 0.5764705882, alpha: 1)
        static var lblValueColor = #colorLiteral(red: 0.4745098039, green: 0.4745098039, blue: 0.4745098039, alpha: 1)
        static var nextDaysColor = #colorLiteral(red: 0.3607843137, green: 0.3607843137, blue: 0.3607843137, alpha: 1)
        static var labelDegreeInfoColor = #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1)
        static var labelDcColor = #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1)
        static var labelStateColor = #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1)
        static var imageIconInfo = #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1)
        static var hourlCollectionViewCellSelectedBgColor = #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
        static var hourlCollectionViewCellSelectedTimeColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        static var hourlCollectionViewCellSelectedDegreeColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        static var hourlCollectionViewCellSelectedIconColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        static var hourlCollectionViewCellSelectedEllipsColor  = #colorLiteral(red: 0.2745098039, green: 0.2745098039, blue: 0.2745098039, alpha: 1)
        static var imageContentArea = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        
        static var cityNameCVColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        static var nextDaysCVColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        static var weatherDetailsInfoCellCVColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        static var weatherDetailInfoCollectionCellColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        static var weatherInfoCellCVColor =  #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        static var collectionViewHourlyWeatherColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        static var collectionContentViewColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        
        
    }
        
    }

