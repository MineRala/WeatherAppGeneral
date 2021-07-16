//
//  WeatherDataStructs.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 13.07.2021.
//

import Foundation
import UIKit

// MARK: - WeatherTableItem
enum WeatherTableItem {
    case cityInfo
    case weatherInfo
    case nextDay
    case hourlyInfo
    case sunDetail
    case windDetail
    
    var height: CGFloat {
        switch self {
        case .cityInfo: return 60
        case .weatherInfo: return 206
        case .nextDay: return 98
        case .hourlyInfo: return 200
        case .sunDetail, .windDetail: return 200
        }
    }
}

// MARK: - List View Data
struct ListViewDataModel {
    let date: Date
    let dayName: String
    let dayAndMonth: String
    let icon: String
    let degree: String
    let windSpeed: String
    let humidity: String
    let pressure: String
    let windDegree: String
    private(set) var isSelected: Bool
    
    mutating func setIsSelected(_ isSelected: Bool) {
        self.isSelected = isSelected
    }
}

// MARK: - Weather View Data
struct WeatherViewDataModel {
    let date: Date 
    let locationText: String
    let weatherState : String
    let weatherDegree : String
    let weatherIcon : String
    let sunriseValue : String
    let sunsetValue : String
    let windSpeedValue : String
    let groundLevelValue : String
    let pressureValue : String
    let seeLevelValue : String
    let humidityValue : String
    let windDegreeValue: String
}

// MARK: - Weather Hourly DataView
struct WeatherHourlyViewDataModel {
    let date: Date
    let timeText: String
    let degreeText: String
    let icon: String
    
    private(set) var isSelected: Bool
    
    mutating func setIsSelected(_ isSelected: Bool) {
        self.isSelected = isSelected
    }
}
