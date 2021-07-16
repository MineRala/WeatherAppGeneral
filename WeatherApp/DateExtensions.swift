//
//  DateExtensions.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 12.07.2021.
//

import Foundation

extension Date {
    var nameOfTheDay: String {
         let date = self
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "EEEE"
         let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
    }
    
    var sunriseAndSunsetValue: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: self)
    }
    
    var numberOfTheDayAndMonth: String {
        let date = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "dd/MM"
        let dayInWeek =  dateFormatter.string(from: date)
        return dayInWeek
    }
    
    var dateUniqueIdentifier: String {
        let date = self
        let identifier =  DateFormatter.dateWeatherFormatter.string(from: date)
        return identifier
    }
    
    var hourUniqueIdentifier: String {
        let date = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "h a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let identifier =  dateFormatter.string(from: date)
        return identifier
    }
    
    var fullDateUniqueIdentifier: String {
        return "\(self.dateUniqueIdentifier)_\(self.hourUniqueIdentifier)"
    }
    
}


extension DateFormatter {
    static let dateWeatherFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "dd_MM_yyyy"
        return dateFormatter
    }()
}
