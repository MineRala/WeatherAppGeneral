//
//  WeatherVDMConverters.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 16.07.2021.
//

import Foundation

class WeatherVDMConverters {
    static func weatherViewDataModel(from listItem: List, city: City) -> WeatherViewDataModel? {
        guard let weather = listItem.weather.first, let main = listItem.main else { return nil }
        let locationText = "\(city.name), \(city.country)"
        let weatherState = weather.description.capitalized
        let weatherDegree = "\(main.temp)"
        let icon = weather.icon.convertToIconName()
        let sunriseVal = Date(timeIntervalSince1970: TimeInterval(city.sunrise)).sunriseAndSunsetValue
        let sunsetVal = Date(timeIntervalSince1970: TimeInterval(city.sunset)).sunriseAndSunsetValue
        let windSpeed = "\(listItem.wind.speed) km/h"
        let groundLevel = "\(main.grnd_level) °"
        let pressureLevel = "\(main.pressure) hPa"
        let seaLevel = "\(main.sea_level) MSL"
        let humidity = "\(main.humidity) g/m^3"
        let windDegree = "\(listItem.wind.deg) °"
        return WeatherViewDataModel(date: listItem.date(), locationText: locationText, weatherState: weatherState, weatherDegree: weatherDegree, weatherIcon: icon, sunriseValue: sunriseVal, sunsetValue: sunsetVal, windSpeedValue: windSpeed, groundLevelValue: groundLevel, pressureValue: pressureLevel, seeLevelValue: seaLevel, humidityValue: humidity, windDegreeValue: windDegree)
    }
    
    static func weatherHourlyViewDataModel(from listItems: [List], selectedDate: Date) -> [WeatherHourlyViewDataModel] {
        let dateUniqueIdentifier = selectedDate.fullDateUniqueIdentifier
        var didSelectedItem = false
        var viewItems = listItems.compactMap { item -> WeatherHourlyViewDataModel? in
            let timeVal = item.dateWithFormat()
            let degreeVal = item.degreeValue()
            let icon = item.weatherIcon()
            let isSelected = item.date().fullDateUniqueIdentifier == dateUniqueIdentifier
            if isSelected { didSelectedItem = true }
            return WeatherHourlyViewDataModel(date: item.date(), timeText: timeVal, degreeText: degreeVal, icon: icon, isSelected: isSelected)
        }
        
        if didSelectedItem == false && viewItems.count > 0 { viewItems[0].setIsSelected(true) }
        return viewItems
    }
    
    static func listViewDataModels(from listItems: [List], selectedDate: Date) -> [ListViewDataModel] {
        let dateUniqueIdentifier = selectedDate.dateUniqueIdentifier
        return listItems.compactMap { model -> ListViewDataModel? in
            guard let main = model.main else { return nil }
            let dayName = model.date().nameOfTheDay
            let dayAndMonth = model.date().numberOfTheDayAndMonth
            let icon = model.weatherIcon()
            let degree = "\(main.temp) °C"
            let windSpeed = "\(model.wind.speed) km/h"
            let humidity = "\(main.humidity) g/m3"
            let pressure = "\(main.pressure) hPa"
            let windDegree = "\(model.wind.deg) °"
            let isSelected = model.date().dateUniqueIdentifier == dateUniqueIdentifier
            return ListViewDataModel(date: model.date(), dayName: dayName, dayAndMonth: dayAndMonth, icon: icon, degree: degree, windSpeed: windSpeed, humidity: humidity, pressure: pressure, windDegree: windDegree, isSelected: isSelected)
        }
    }
}
