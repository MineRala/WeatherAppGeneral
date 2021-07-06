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

    @IBOutlet weak var mainViewControllerView: UIView!
    @IBOutlet weak var tableViewMain: UITableView!
    
    private var viewModel: MainViewModel!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = MainViewModel(delegate: self)
        setUpUI()
        viewModel.initialize()
     //   darkModeColor()
    }
    
    private func darkModeColor(){
       
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.view.backgroundColor = C.Color.viewControllerBackgroundColor
        self.tableViewMain.reloadData()
    }
    
    func printError(error:Error){
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
          
    }
    
    private func setUpUI() {
        self.view.backgroundColor = C.Color.viewControllerBackgroundColor
        tableViewMain.register(UINib(nibName: "CityNameCell", bundle: nil), forCellReuseIdentifier: "CityNameCell")
        tableViewMain.register(UINib(nibName: "WeatherInfoCell", bundle: nil), forCellReuseIdentifier: "WeatherInfoCell")
        tableViewMain.register(UINib(nibName: "NextDayCell", bundle: nil), forCellReuseIdentifier: "NextDayCell")
        tableViewMain.register(UINib(nibName: "WeatherHourlyCell", bundle: nil), forCellReuseIdentifier: "WeatherHourlyCell")
        tableViewMain.register(UINib(nibName: "WeatherDetailsInfoCell", bundle: nil), forCellReuseIdentifier: "WeatherDetailsInfoCell")
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        
//        if traitCollection.userInterfaceStyle == .dark {
//            C.Color.cityNameCVColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
//            C.Color.cityInfoTitleColor = #colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)
//            C.Color.nextDaysCVColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
//            C.Color.weatherDetailsInfoCellCVColor = #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 1)
//            C.Color.weatherDetailInfoCollectionCellColor = #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 1)
//            C.Color.weatherInfoCellCVColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
//            self.mainViewControllerView.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
//            C.Color.lblTitleColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
//            C.Color.lblValueColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
//            C.Color.labelDegreeInfoColor = #colorLiteral(red: 0.8078431373, green: 0.8078431373, blue: 0.8078431373, alpha: 1)
//            C.Color.labelDcColor = #colorLiteral(red: 0.8078431373, green: 0.8078431373, blue: 0.8078431373, alpha: 1)
//            C.Color.labelStateColor = #colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)
//            C.Color.imageIconColor = #colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)
//            C.Color.nextDaysColor = #colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)
//            C.Color.collectionViewHourlyWeatherColor = #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 1)
//            C.Color.collectionContentViewColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            C.Color.labelDegreeColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
//            C.Color.labelTimeColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
//            C.Color.imageContentArea = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
//            C.Color.imageIconColor = #colorLiteral(red: 0.4862745098, green: 0.4823529412, blue: 0.4823529412, alpha: 1)
//        }
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
            cell.configureCell(viewModel: viewModel)
            return cell
            
        case .weatherInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInfoCell", for: indexPath) as! WeatherInfoCell
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
            return cell
            
        case .windDetail:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailsInfoCell", for: indexPath) as! WeatherDetailsInfoCell
            cell.configureCell(viewModel: viewModel, cellType: .bottom)
            return cell
            
        default:
            fatalError()
        }
    }
}

//MARK : MainViewModel Delegate
extension MainViewController: MainViewModelDelegate {
    func mainViewModelDidUpdatedWeatherInfo(_ viewModel: MainViewModel) {
        DispatchQueue.main.async {
            self.tableViewMain.reloadData()
        }
    }
    
    func mainViewModelDidOccuredError(_ viewModel: MainViewModel, error: Error) {
        printError(error: error)
        self.tableViewMain.reloadData()
    }
}
