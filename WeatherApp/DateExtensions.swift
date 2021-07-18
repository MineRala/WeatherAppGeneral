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
        let identifier = DateFormatter.nameOfTheDayFormatter.string(from: date)
        return identifier
    }
    
    var sunriseAndSunsetValue: String {
        let data = self
        let identifier = DateFormatter.sunriseAndSunsetValueFormatter.string(from: data)
        return identifier
    }
    
    var numberOfTheDayAndMonth: String {
        let data = self
        let identifier = DateFormatter.numberOfTheDayAndMonthFormatter.string(from: data)
        return identifier
    }
    
    var dateUniqueIdentifier: String {
        let date = self
        let identifier =  DateFormatter.dateWeatherFormatter.string(from: date)
        return identifier
    }
    
    var hourUniqueIdentifier: String {
        let date = self
        let identifier =  DateFormatter.hourWeatherFormatter.string(from: date)
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
    
    static let hourWeatherFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "h a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter
    }()
    
    static let nameOfTheDayFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }()
    
    static let sunriseAndSunsetValueFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter
    }()
    
    static let numberOfTheDayAndMonthFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "dd/MM"
        return dateFormatter
    }()
}


