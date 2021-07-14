//
//  Configuration.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 5.07.2021.
//

import Foundation
import UIKit

let KeyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first


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
        static var cityInfoTitleColor : UIColor { UITraitCollection.current.userInterfaceStyle == .light ?  #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1) :#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)}
        static var labelDegreeColor : UIColor { UITraitCollection.current.userInterfaceStyle == .light ?   #colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1) : #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)}
        static var labelTimeColor : UIColor { UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1) :#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)}
        static var imageIconColor : UIColor { UITraitCollection.current.userInterfaceStyle == .light ?  #colorLiteral(red: 0.4862745098, green: 0.4823529412, blue: 0.4823529412, alpha: 1): #colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)}
        static var lblTitleColor : UIColor { UITraitCollection.current.userInterfaceStyle == .light ?  #colorLiteral(red: 0.5764705882, green: 0.5764705882, blue: 0.5764705882, alpha: 1):#colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)}
        static var lblValueColor : UIColor { UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.4745098039, green: 0.4745098039, blue: 0.4745098039, alpha: 1) :#colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)}
        static var nextDaysColor : UIColor { UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.3607843137, green: 0.3607843137, blue: 0.3607843137, alpha: 1) : #colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)}
        static var labelDegreeInfoColor : UIColor { UITraitCollection.current.userInterfaceStyle == .light ?  #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1): #colorLiteral(red: 0.8078431373, green: 0.8078431373, blue: 0.8078431373, alpha: 1)}
            static var labelDcColor :UIColor { UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1) : #colorLiteral(red: 0.8078431373, green: 0.8078431373, blue: 0.8078431373, alpha: 1)}
        static var labelStateColor :UIColor { UITraitCollection.current.userInterfaceStyle == .light ?   #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1): #colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)}
        static var imageIconInfo : UIColor { UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1) :#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)}
        static var hourlCollectionViewCellSelectedBgColor : UIColor { UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1) :#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)}
        
        static var hourlCollectionViewCellSelectedTimeColor : UIColor { UITraitCollection.current.userInterfaceStyle == .light ?  #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1) :#colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)}
            static var hourlCollectionViewCellSelectedDegreeColor : UIColor { UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1) :#colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)}
        static var hourlCollectionViewCellSelectedIconColor :UIColor { UITraitCollection.current.userInterfaceStyle == .light ?   #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1) :#colorLiteral(red: 0.4862745098, green: 0.4823529412, blue: 0.4823529412, alpha: 1)}
        static var hourlCollectionViewCellSelectedEllipsColor  : UIColor { UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.2745098039, green: 0.2745098039, blue: 0.2745098039, alpha: 1) :#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)}
        static var imageContentArea : UIColor {
            UITraitCollection.current.userInterfaceStyle == .light ?  #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1) : #colorLiteral(red: 0.4862745098, green: 0.4823529412, blue: 0.4823529412, alpha: 1)}
        
        static var weatherHourlyCellContentView : UIColor { UITraitCollection.current.userInterfaceStyle == .light ?  #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1) : #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 1)}
       
       
        
        static var cityNameCVColor : UIColor { UITraitCollection.current.userInterfaceStyle == .light ?  #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)  : #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)}
        static var nextDaysCVColor : UIColor { UITraitCollection.current.userInterfaceStyle == .light ?  #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)  : #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)}
        static var weatherDetailsInfoCellCVColor : UIColor { UITraitCollection.current.userInterfaceStyle == .light ?  #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)   : #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 1)}
        static var weatherDetailInfoCollectionCellColor : UIColor { UITraitCollection.current.userInterfaceStyle == .light ?   UIColor.clear  :#colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 1)}
        static var weatherInfoCellCVColor :  UIColor { UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1) : #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)}
        static var collectionViewHourlyWeatherColor : UIColor { UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)  : #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 1)}
        static var collectionContentViewColor : UIColor { UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)}
        
        static var toastBackgroundColor: UIColor { UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) :  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)}

        static var toastTextColor: UIColor { UITraitCollection.current.userInterfaceStyle == .light ?  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0):  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) }
        
        
        static var daysViewColor: UIColor{ UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1):  #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1) }
        static var backButtonColor: UIColor{ UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1) : #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1) }
        
        static var labelNext5DaysColor: UIColor{ UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1) : #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1) }
        
        static var cellContentViewColor: UIColor{ UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1) : #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1) }

        static var cellViewColor: UIColor{ UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1) : #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 1) }
        static var ipadCollectionViewInfoColor: UIColor{ UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.5764705882, green: 0.5764705882, blue: 0.5764705882, alpha: 1) : #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1) }
        static var ipadCollectionViewInfoValueColor: UIColor{ UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.4745098039, green: 0.4745098039, blue: 0.4745098039, alpha: 1) : #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1) }
        
        static var ipadCollectionViewBackgroundColor: UIColor{ UITraitCollection.current.userInterfaceStyle == .light ? #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1) : #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 1) }
        
    }
    }

