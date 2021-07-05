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
    
    private(set) var city: City!
    private(set) var dailyWeather: [Date: [List]] = [:]
    private(set) var currentHourlyWeatherData: [List] = []
    private(set) var currentWeather: List!
    
    private(set) var arrItems: [WeatherTableItem] = []
    
    private weak var delegate: MainViewModelDelegate?
    
    // MARK: - Getters
    var cityName: String {
        return city.name
    }
    
    var countryName: String {
        return city.country
    }
    
    var weatherState: String {
        guard let weather = currentWeather.weather.first else { return "" }
        return weather.description.capitalized
    }
    
    var weatherDegree: String {
        guard let main = currentWeather.main else { return "" }
        return "\(main.temp)"
    }
    
    var weatherIcon: String {
        guard let weather = currentWeather.weather.first else { return "" }
        return weather.icon.convertToIconName()
    }
    
    var sunriseValue: String {
        return "".sunriseAndSunsetValue(value: Int(self.city.sunrise))
    }
    
    var sunsetValue: String {
        return "".sunriseAndSunsetValue(value: Int(self.city.sunset))
    }
    
    var windSpeedValue: String {
        return "\(currentWeather.wind.speed) km/h"
    }

    var windDegreeValue: String {
        return "\(currentWeather.wind.deg) °C"
    }
    
    var groundLevelValue : String {
        return "\(currentWeather.main!.grnd_level)"
    }
    
    var pressureValue : String {
        return "\(currentWeather.main!.pressure) hPa"
    }
    
    var seeLevelValue : String {
        return "\(currentWeather.main!.sea_level) MSL"
    }
    
    var humudityVaalue : String {
        return "\(currentWeather.main!.humidity) g/m3"
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
    
    func getTodayForecastList() -> [List] {
        return self.currentHourlyWeatherData
    }
    
    func isCurrentForecastTimeModel(timeForecast: List) -> Bool {
        let currentForecastTime = currentWeather.date()
        let listForecastTime = timeForecast.date()
        return listForecastTime == currentForecastTime
    }
    
    func updateCurrentWeather(_ list: List) {
        self.currentWeather = list
        self.delegate?.mainViewModelDidUpdatedWeatherInfo(self)
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
        self.currentHourlyWeatherData = Array(sortedWeatherData[0 ..< C.App.numberOfItemsInHourlyCollectionView])
        
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
