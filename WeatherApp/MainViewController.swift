//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Mine Rala on 1.07.2021.
//

import UIKit
import CoreLocation
import SwiftLocation
import Combine

enum DetailIInfoCellType {
    case top
    case bottom 
}

class MainViewController: UIViewController {

    @IBOutlet weak var mainViewControllerView: UIView!
    @IBOutlet weak var tableViewMain: UITableView!
    
    private let viewModel = MainViewModel()
    private let refreshControl = UIRefreshControl()
    
    private var cancellables = Set<AnyCancellable>()
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        addListeners()
        viewModel.initialize()
    }
}

//MARK: -Set up uı
extension MainViewController{
    private func setUpUI() {
        self.mainViewControllerView.backgroundColor  = C.Color.viewControllerBackgroundColor
        tableViewMain.register(UINib(nibName: "CityNameCell", bundle: nil), forCellReuseIdentifier: "CityNameCell")
        tableViewMain.register(UINib(nibName: "WeatherInfoCell", bundle: nil), forCellReuseIdentifier: "WeatherInfoCell")
        tableViewMain.register(UINib(nibName: "NextDayCell", bundle: nil), forCellReuseIdentifier: "NextDayCell")
        tableViewMain.register(UINib(nibName: "WeatherHourlyCell", bundle: nil), forCellReuseIdentifier: "WeatherHourlyCell")
        tableViewMain.register(UINib(nibName: "WeatherDetailsInfoCell", bundle: nil), forCellReuseIdentifier: "WeatherDetailsInfoCell")
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        
        tableViewMain.refreshControl = refreshControl
        refreshControl.addTarget(viewModel, action: #selector(MainViewModel.initialize), for: .valueChanged)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.mainViewControllerView.backgroundColor  = C.Color.viewControllerBackgroundColor
        
        self.tableViewMain.reloadData()
    }
}

//MARK: - Table View
extension MainViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var insetBottom: CGFloat = 0
        if indexPath.row == viewModel.arrItems.count - 1 {
            insetBottom = 36
        }
        return viewModel.arrItems[indexPath.row].height + insetBottom
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
            cell.configureCell(viewModel)
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
        }
   }
}

// MARK: - Listeners
extension MainViewController {
    private func addListeners() {
        viewModel.shouldUpdateTableView.receive(on: DispatchQueue.main).sink { _ in
            self.tableViewMain.reloadData()
            self.refreshControl.endRefreshing()
        }.store(in: &cancellables)
        
        viewModel.shouldShowAlertViewForError.receive(on: DispatchQueue.main).sink { error in
            self.printError(error: error)
            self.tableViewMain.reloadData()
            self.refreshControl.endRefreshing()
        }.store(in: &cancellables)
        
        viewModel.shouldNavigateToDaysViewController.receive(on: DispatchQueue.main).sink { _ in
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(identifier: "DaysViewController") as! DaysViewController
            vc.setViewModel(self.viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }.store(in: &cancellables)
        
        Network.shared.networkStatus.receive(on: DispatchQueue.main).sink { status in
            print("Current Status: \(status)")
            if status == .offline{
                ToastView.show(with: "No internet connection !")
            }
        }.store(in: &cancellables)
    }
}

//MARK: Print Error
extension MainViewController {
    func printError(error: WeatherAppError){
        if error == .noInternetConnection {
            ToastView.show(with: "No internet connection !")
        } else {
            self.showAlert(with: error.title, message: error.errorDescription)
        }
    }
}
