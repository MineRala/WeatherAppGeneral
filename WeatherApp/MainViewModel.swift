//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 2.07.2021.
//

import Foundation
import SwiftLocation
import CoreLocation

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
        case .weatherInfo: return 250
        case .nextDay: return 52
        case .hourlyInfo: return 180
        case .sunDetail, .windDetail: return 200
        }
    }
}

// MARK: - MainViewModel Delegate
protocol MainViewModelDelegate: class {
    func mainViewModelDidUpdatedWeatherInfo(_ viewModel: MainViewModel)
    func mainViewModelDidOccuredError(_ viewModel: MainViewModel, error: Error)
}

// MARK: Main View Model {Class}
class MainViewModel {
    private let apiService = APIService()
    
    private weak var delegate: MainViewModelDelegate?
    private(set) var city: City!
    private(set) var dailyWeather: [Date: [List]] = [:] // TODO: Date : key
    private(set) var currentWeather: List!
    
    private(set) var arrItems: [WeatherTableItem] = []
    
    // MARK: - Getters
    var cityName: String {
        return city.name
    }
    
    var countryName: String {
        return city.country
    }
    
    var weatherState: String {
        guard let weather = currentWeather.weather.first else { return "" }
        return weather.main
    }
    
    var weatherDegree: String {
        guard let main = currentWeather.main else { return "" }
        return "\(main.temp)"
    }
    
    var weatherIcon: String {
        guard let weather = currentWeather.weather.first else { return "" }
        return MainViewModel.weatherIconName(from: weather.icon)
    }

    init(delegate: MainViewModelDelegate) {
        self.delegate = delegate
    }
}

// MARK: - Public
extension MainViewModel {
    func initialize() {
        self.findUserCoordinates { (coordinate, error) in
            if let error = error {
                self.delegate?.mainViewModelDidOccuredError(self, error: error)
                return
            }
            self.requestWeatherInfo(coordinates: coordinate!) { weatherModel in
                self.processResponse(weatherModel)
            }
        }
    }
}

// MARK: - API Request
extension MainViewModel {
    private func requestWeatherInfo(coordinates: CLLocationCoordinate2D, callback: @escaping (WeatherModel)->() ) {
        self.apiService.request(service: .cityLocation(coordinates.latitude, coordinates.longitude)) { (data, error) in
            if let error = error {
                self.delegate?.mainViewModelDidOccuredError(self, error: error)
                return
            }
            let response = try! JSONDecoder().decode(WeatherModel.self, from:data!)
            callback(response)
        }
    }
    
    private func processResponse(_ response: WeatherModel) {
        guard let city = response.city, let weatherData = response.list else {
            // TODO: city veya weather data yok. Hata alerti göster
            return
        }
        
        let sortedWeatherData = weatherData.sorted { (we1, we2) -> Bool in
            let date1 = Date(timeIntervalSince1970: TimeInterval(we1.dt!))
            let date2 = Date(timeIntervalSince1970: TimeInterval(we2.dt!))
            return date1 < date2
        }
        
        var dct: [String: [List]] = [:]
        self.dailyWeather = [:]
        weatherData.forEach { weather in
            let interval = TimeInterval(weather.dt!)
            let date = Date(timeIntervalSince1970: interval)
            let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
            let identifier = "\(calendarDate.day!)-\(calendarDate.month!)-\(calendarDate.year!)"
            let dayDate = self.dateFrom(day: calendarDate.day!, month: calendarDate.month!, year: calendarDate.year!)
            if dct.keys.contains(identifier) {
                var arr = dct[identifier]!
                arr.append(weather)
                dct[identifier] = arr
                var arrDateDct = self.dailyWeather[dayDate]!
                arrDateDct.append(weather)
                self.dailyWeather[dayDate] = arrDateDct
            } else {
                dct[identifier] = [weather]
                self.dailyWeather[dayDate] = [weather]
            }
        }
        
        self.currentWeather = sortedWeatherData.first!
        self.city = city
        
        self.arrItems = [.cityInfo, .weatherInfo, .nextDay, .hourlyInfo, .sunDetail, .windDetail]
        self.delegate?.mainViewModelDidUpdatedWeatherInfo(self)
    }
    
    private func dateFrom(day: Int, month: Int, year: Int) -> Date {
        var components = DateComponents()
        components.hour = 0
        components.minute = 0
        components.second = 0
        components.day = day
        components.month = month
        components.year = year
        let date = Calendar.current.date(from: components)
        return date!
    }
}

/**
 
 self.apiService.request(service: .cityLocation(newData.coordinate.latitude, newData.coordinate.longitude)) { (data, error) in
     //parse
     let response = try! JSONDecoder().decode(WeatherModel.self, from:data!)
     self.processResponse(response)
     DispatchQueue.main.async {
         self.tableViewMain.reloadData()
     }
 }
 
 
 private func processResponse(_ response: WeatherModel) {
     guard let city = response.city, let weatherData = response.list else {
         // TODO: city veya weather data yok. Hata alerti göster
         return
     }
     
     let sortedWeatherData = weatherData.sorted { (we1, we2) -> Bool in
         let date1 = Date(timeIntervalSince1970: TimeInterval(we1.dt!))
         let date2 = Date(timeIntervalSince1970: TimeInterval(we2.dt!))
         return date1 < date2
     }
     self.currentWeather = sortedWeatherData.first!
    
     
     self.city = city
     var dct: [String: [List]] = [:]
     weatherData.forEach { weather in
         let interval = TimeInterval(weather.dt!)
         let date = Date(timeIntervalSince1970: interval)
         let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
         let identifier = "\(calendarDate.day)-\(calendarDate.month)-\(calendarDate.year)"
         if dct.keys.contains(identifier) {
             var arr = dct[identifier]!
             arr.append(weather)
             dct[identifier] = arr
         } else {
             dct[identifier] = [weather]
         }
     }
     self.dailyWeather = dct
 }
 
 
 
 */

// MARK: - Weather Icon
extension MainViewModel {
    private static func weatherIconName(from iconIdentifier: String) -> String {
        switch iconIdentifier {
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
            fatalError("Icon Not Added")
        }
    }
}

// MARK: - User Location
extension MainViewModel {
    private func findUserCoordinates(callback: @escaping (CLLocationCoordinate2D?, Error?) -> ()) {
        SwiftLocation.gpsLocationWith {
            $0.subscription = .single
            $0.accuracy = .block
        }.then { result in // you can attach one or more subscriptions via `then`.
            switch result {
            case .success(let newData):
                print(newData)
                callback(newData.coordinate, nil)
            case .failure(let error):
                callback(nil, error)
                //print("An error has occurred: \(error.localizedDescription)")
            }
        }
    }
}
