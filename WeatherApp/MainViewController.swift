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

struct MainViewControllerDependency {
    let viewModel: MainViewModel!
    let selectedDate: Date?
    let isFromDaysViewController: Bool
    let nameOfTheDay: String?
}

class MainViewController: UIViewController {
    private var currentDependency = MainViewControllerDependency(viewModel: MainViewModel(), selectedDate: nil, isFromDaysViewController: false, nameOfTheDay: nil)
    
    @IBOutlet weak var mainViewControllerView: UIView!
    @IBOutlet weak var tableViewMain: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblDayName: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    private let refreshControl = UIRefreshControl()
    private var cancellables = Set<AnyCancellable>()
    
    private var viewModel: MainViewModel { return currentDependency.viewModel }
    private var isFromListVC: Bool { return currentDependency.isFromDaysViewController }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}

// MARK: - Lifecycle
extension MainViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        addListeners()
        viewModel.initialize(with: currentDependency.selectedDate)
    }
    
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    
}

// MARK: - Actions
extension MainViewController {
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func refreshViewDatas() {
        self.viewModel.reset()
        self.viewModel.initialize(with: nil)
    }
}

//MARK: - Set up UI
extension MainViewController{
    private func setUpUI() {
        
        self.tableViewTopConstraint.constant = self.isFromListVC ? 88.0 : 0.0
        self.viewHeader.alpha = self.isFromListVC ? 1.0 : 0.0
        self.mainViewControllerView.backgroundColor  = C.Color.viewControllerBackgroundColor
        tableViewMain.register(UINib(nibName: "CityNameCell", bundle: nil), forCellReuseIdentifier: "CityNameCell")
        tableViewMain.register(UINib(nibName: "WeatherInfoCell", bundle: nil), forCellReuseIdentifier: "WeatherInfoCell")
        tableViewMain.register(UINib(nibName: "NextDayCell", bundle: nil), forCellReuseIdentifier: "NextDayCell")
        tableViewMain.register(UINib(nibName: "WeatherHourlyCell", bundle: nil), forCellReuseIdentifier: "WeatherHourlyCell")
        tableViewMain.register(UINib(nibName: "WeatherDetailsInfoCell", bundle: nil), forCellReuseIdentifier: "WeatherDetailsInfoCell")
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        
        if self.isFromListVC == false {
            tableViewMain.refreshControl = refreshControl
            refreshControl.addTarget(self, action: #selector(refreshViewDatas), for: .valueChanged)
        }
       
        if let dayName = currentDependency.nameOfTheDay {
            self.lblDayName.text = dayName
        }
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil 
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.mainViewControllerView.backgroundColor  = C.Color.viewControllerBackgroundColor
        
        self.tableViewMain.reloadData()
    }
}

// MARK: - Public
extension MainViewController {
    func setDependency(_ dependency: MainViewControllerDependency) {
        self.currentDependency = dependency
    }
}

//MARK: - Table View
extension MainViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrTableViewItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var insetBottom: CGFloat = 0
        if indexPath.row == viewModel.arrTableViewItems.count - 1 {
            insetBottom = 36
        }
        
        let selectedItem = viewModel.arrTableViewItems[indexPath.row]
        if selectedItem == .nextDay && isFromListVC{
            return 0
        }
        return viewModel.arrTableViewItems[indexPath.row].height + insetBottom
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentItem = viewModel.arrTableViewItems[indexPath.row]
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
        viewModel.shouldShowLoadingAnimation.receive(on: DispatchQueue.main).sink { isShowing in
            isShowing == true ? LoadingView.show() : LoadingView.hide()
        }.store(in: &cancellables)
        
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
