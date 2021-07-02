//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Mine Rala on 1.07.2021.
//

import UIKit
import CoreLocation
import SwiftLocation

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableViewMain: UITableView!
    private let apiService = APIService()
    
    
    var city: City!
    var dailyWeather: [String: [List]] = [:] // String 02-07-2021
    var currentWeather: List!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewMain.register(UINib(nibName: "CityNameCell", bundle: nil), forCellReuseIdentifier: "CityNameCell")
        tableViewMain.register(UINib(nibName: "WeatherInfoCell", bundle: nil), forCellReuseIdentifier: "WeatherInfoCell")
        tableViewMain.register(UINib(nibName: "NextDayCell", bundle: nil), forCellReuseIdentifier: "NextDayCell")
        tableViewMain.register(UINib(nibName: "WeatherHourlyCell", bundle: nil), forCellReuseIdentifier: "WeatherHourlyCell")
        tableViewMain.register(UINib(nibName: "WeatherDetailsInfoCell", bundle: nil), forCellReuseIdentifier: "WeatherDetailsInfoCell")
        
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
  
        SwiftLocation.gpsLocationWith {
            // configure everything about your request
            $0.subscription = .single // continous updated until you stop it
            $0.accuracy = .block
        }.then { result in // you can attach one or more subscriptions via `then`.
            switch result {
            case .success(let newData):
                print(newData)
                self.apiService.request(service: .cityLocation(newData.coordinate.latitude, newData.coordinate.longitude)) { (data, error) in
                    //parse
                    let response = try! JSONDecoder().decode(WeatherModel.self, from:data!)
                    self.processResponse(response)
                    DispatchQueue.main.async {
                        self.tableViewMain.reloadData()
                    }
                }
            case .failure(let error):
                print("An error has occurred: \(error.localizedDescription)")
            }
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
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.city == nil { return 0 }
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 60
        case 1:
            return 180
        case 2:
            return 52
        case 3:
            return 180
        case 4,5:
            return 200
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CityNameCell",for: indexPath)as! CityNameCell
            cell.configureCell(cityName: city.name, countryName: city.country)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInfoCell", for: indexPath) as! WeatherInfoCell
            cell.configureCell(state: self.currentWeather.weather.first!.main, degree: currentWeather.main!.temp, iconIdentifier: currentWeather.weather.first!.icon)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NextDayCell", for: indexPath) as! NextDayCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherHourlyCell", for: indexPath) as! WeatherHourlyCell
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailsInfoCell", for: indexPath) as! WeatherDetailsInfoCell
            cell.configureCell(sunset: city.sunset, sunrise: city.sunrise, seaLevel: currentWeather.main!.sea_level, grnLevel: currentWeather.main!.grnd_level)
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailsInfoCell", for: indexPath) as! WeatherDetailsInfoCell
            cell.configureCell(windSpeed: currentWeather.wind.speed, windDegree: currentWeather.wind.deg, pressure: currentWeather.main!.pressure, humudity: currentWeather.main!.humidity)
            return cell
        default:
            fatalError()
        }
    }
}
