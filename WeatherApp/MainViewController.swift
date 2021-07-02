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
    var response =  WeatherModel()
   
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
                    self.response = response
                    DispatchQueue.main.async {
                        self.tableViewMain.reloadData()
                    }
                }
            case .failure(let error):
                print("An error has occurred: \(error.localizedDescription)")
            }
        }


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
            guard let city = response.city  else{
                cell.lblCity.text = ""
                return cell
            }
            cell.lblCity.text = response.city!.name  + response.city!.country
            return cell
        }
         else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInfoCell",for: indexPath)as! WeatherInfoCell
            guard let degree = response.list else{
                cell.labelDegree.text = ""
                return cell
            }
 //           cell.labelDegree.text = "\(response.list![1].main!.temp)"
//            guard let icon = response.list![2].weather[] else{
//                cell.ImageIcon.image = UIImage(named: "")
//                return cell
//            }
//            cell.ImageIcon.image = UIImage(named: "\(response.list![2].weather[3])")
//
            // cell.ImageIcon = response.list.
//            guard let state = response.list?[2].weather else{
//                cell.labelState.text = ""
//                return cell
//            }
//            cell.labelState.text = "\(response.list![2].weather[1])"
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
