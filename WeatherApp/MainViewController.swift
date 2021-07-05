//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Mine Rala on 1.07.2021.
//

import UIKit
import CoreLocation
import SwiftLocation

enum DetailIInfoCellType {
    case top
    case bottom 
}

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    @IBOutlet weak var tableViewMain: UITableView!
    
    private var viewModel: MainViewModel!
  
    override func viewDidLoad() {
        super.viewDidLoad()

       
        viewModel = MainViewModel(delegate: self)
        setUpUI()
        viewModel.initialize()
        
        UIFont.familyNames.forEach({ familyName in
                    let fontNames = UIFont.fontNames(forFamilyName: familyName)
                    print(familyName, fontNames)
                })
        
        print("asdads")
    }
    
    private func setUpUI() {
        tableViewMain.register(UINib(nibName: "CityNameCell", bundle: nil), forCellReuseIdentifier: "CityNameCell")
        tableViewMain.register(UINib(nibName: "WeatherInfoCell", bundle: nil), forCellReuseIdentifier: "WeatherInfoCell")
        tableViewMain.register(UINib(nibName: "NextDayCell", bundle: nil), forCellReuseIdentifier: "NextDayCell")
        tableViewMain.register(UINib(nibName: "WeatherHourlyCell", bundle: nil), forCellReuseIdentifier: "WeatherHourlyCell")
        tableViewMain.register(UINib(nibName: "WeatherDetailsInfoCell", bundle: nil), forCellReuseIdentifier: "WeatherDetailsInfoCell")
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
    }
    
   

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.arrItems[indexPath.row].height
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentItem = viewModel.arrItems[indexPath.row]
        switch currentItem {
        case .cityInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CityNameCell",for: indexPath)as! CityNameCell
           // cell.configureCell(cityName: city.name, countryName: city.country)
            cell.configureCell(viewModel: viewModel)
            return cell
        case .weatherInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInfoCell", for: indexPath) as! WeatherInfoCell
            //cell.configureCell(state: self.currentWeather.weather.first!.main, degree: currentWeather.main!.temp, iconIdentifier: currentWeather.weather.first!.icon)
            cell.configureCell(viewModel)
            return cell
        case .nextDay:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NextDayCell", for: indexPath) as! NextDayCell
            return cell
        case .hourlyInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherHourlyCell", for: indexPath) as! WeatherHourlyCell
            cell.configureCell(viewModel)
            return cell
        case .sunDetail:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailsInfoCell", for: indexPath) as! WeatherDetailsInfoCell
            cell.configureCell(viewModel: viewModel, cellType: .top)
            //cell.configureCell(sunset: city.sunset, sunrise: city.sunrise, seaLevel: currentWeather.main!.sea_level, grnLevel: currentWeather.main!.grnd_level)
            return cell
        case .windDetail:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailsInfoCell", for: indexPath) as! WeatherDetailsInfoCell
            cell.configureCell(viewModel: viewModel, cellType: .bottom)
            //cell.configureCell(windSpeed: currentWeather.wind.speed, windDegree: currentWeather.wind.deg, pressure: currentWeather.main!.pressure, humudity: currentWeather.main!.humidity)
            return cell
        default:
            fatalError()
        }
    }
 
}

// MARK: MainViewModel Delegate
extension MainViewController: MainViewModelDelegate {
    func mainViewModelDidUpdatedWeatherInfo(_ viewModel: MainViewModel) {
        DispatchQueue.main.async {
            self.tableViewMain.reloadData()
        }
    }
    
    func mainViewModelDidOccuredError(_ viewModel: MainViewModel, error: Error) {
        print("Current Error: \(error)")
        self.tableViewMain.reloadData()
    }
}
