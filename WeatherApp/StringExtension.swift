//
//  StringExtension.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 5.07.2021.
//

import Foundation

extension String {
    func convertToIconName() -> String {
        print("ICON: \(self)")
        switch self {
        case "01d", "01n":
            return "sun.max"
        case "02d", "02n":
            return "cloud.sun"
        case "03d", "03n":
            return "cloud"
        case "04d", "04n":
            return "smoke"
        case "09d", "09n":
            return "cloud.heavyrain"
        case "10d", "10n":
            return "cloud.rain"
        case "11d", "11n":
            return "cloud.bolt"
        case "13d", "13n":
            return "snow"
        case "50d", "50n":
            return "cloud.fog"
        default:
            return ""
        }
    }
    
    func sunriseAndSunsetValue(value:Int) -> String{
        let timeInterval = TimeInterval(value)
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: date)
    }
}
