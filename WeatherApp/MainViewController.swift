//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Mine Rala on 1.07.2021.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {

    @IBOutlet weak var tableViewMain: UITableView!
    private let apiService = APIService()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewMain.register(UINib(nibName: "CityNameCell", bundle: nil), forCellReuseIdentifier: "CityNameCell")
        tableViewMain.register(UINib(nibName: "WeatherInfoCell", bundle: nil), forCellReuseIdentifier: "WeatherInfoCell")
        tableViewMain.register(UINib(nibName: "NextDayCell", bundle: nil), forCellReuseIdentifier: "NextDayCell")
        tableViewMain.register(UINib(nibName: "WeatherHourlyCell", bundle: nil), forCellReuseIdentifier: "WeatherHourlyCell")
        tableViewMain.register(UINib(nibName: "WeatherDetailsInfoCell", bundle: nil), forCellReuseIdentifier: "WeatherDetailsInfoCell")
        
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways: break
        case .authorizedWhenInUse: break
        case .denied: break
        case .notDetermined: break
        case .restricted: break
        default:
            fatalError()
        }
        print(status)
      
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        apiService.request(service: .cityLocation(45.1414, 50.5921)) { (data, error) in
            //parse
            let response = try! JSONDecoder().decode(WeatherModel.self, from:data!)
            print("cod: \(response.cod)")
            print("message: \(response.message)")
            print("cnt: \(response.cnt)")
            response.list?.forEach { (lists) in
                print(lists.dt ?? "")
            }
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            apiService.request(service: .cityLocation(latitude, longitude)) { (data, error) in
                //parse
                let response = try! JSONDecoder().decode(WeatherModel.self, from:data!)
                print("cod: \(response.cod)")
                print("message: \(response.message)")
                print("cnt: \(response.cnt)")
                response.list?.forEach { (lists) in
                    print(lists.dt ?? "")
                }
            }
            print(latitude)
            print(longitude)
        }
    
    }
    
    func locationManager(_ manager: CLLocationManager,didFailWithError error: Error){
        print(error)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return  60        }
        if indexPath.row == 1 {
            return  180        }
        if indexPath.row == 2 {
            return  52
        }
         if indexPath.row == 3 {
            return 180
        }
        if indexPath.row == 4 {
            return 300
        }
        fatalError()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CityNameCell",for: indexPath)as! CityNameCell
            return cell
        }
         else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInfoCell",for: indexPath)as! WeatherInfoCell
            return cell
        }
         else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NextDayCell",for: indexPath)as! NextDayCell
            return cell
        }
         else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherHourlyCell",for: indexPath)as! WeatherHourlyCell
            return cell
        }
         else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailsInfoCell",for: indexPath)as! WeatherDetailsInfoCell
            return cell
        }
        fatalError()
    }
    
    
}
