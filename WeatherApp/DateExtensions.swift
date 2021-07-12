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
}
