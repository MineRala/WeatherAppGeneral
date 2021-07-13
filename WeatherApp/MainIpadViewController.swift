//
//  MainIpadViewController.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 5.07.2021.
//

import UIKit
import Combine

class MainIpadViewController: UIViewController {
    
    @IBOutlet weak var viewContainerWeatherDataCollectionView: UIView!
    @IBOutlet weak var viewContainerDayTableView: UIView!
    @IBOutlet weak var viewContainerHourTableView: UIView!
   
    @IBOutlet weak var imViewIcon: UIImageView!
    @IBOutlet weak var lblWeatherState: UILabel!
    @IBOutlet weak var lblDegree: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    
    private var dayTableVC: DayTableViewController!
    private var hourTableVC: HourTableViewController!
    private var weatherDataCollectionVC: WeatherDataCollectionView!

    private let viewModel = MainViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
}

// MARK: - Lifecycle
extension MainIpadViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        addListeners()
        viewModel.initialize()
    }
}

// MARK: - Set Up UI
extension MainIpadViewController {
    private func setUpUI() {
        self.view.backgroundColor = C.Color.viewControllerBackgroundColor
        
        self.children.forEach { childVC in
            if let viewController = childVC as? DayTableViewController {
                self.dayTableVC = viewController
                dayTableVC.setViewModel(self.viewModel)
            } else if let viewController = childVC as? HourTableViewController {
                self.hourTableVC = viewController
                hourTableVC.setViewModel(self.viewModel)
            } else if let viewController = childVC as? WeatherDataCollectionView {
                self.weatherDataCollectionVC = viewController
                weatherDataCollectionVC.setViewModel(self.viewModel)
            }
        }
    }
}

// MARK: - Update Info
extension MainIpadViewController {
    private func updateWeatherInfoUI() {
        guard self.viewModel.currentWeatherViewData != nil else { return }
        self.lblCity.text = self.viewModel.currentWeatherViewData.locationText
        self.lblDegree.text = self.viewModel.currentWeatherViewData.weatherDegree
        self.imViewIcon.image = UIImage(systemName: viewModel.currentWeatherViewData.weatherIcon)
        self.lblWeatherState.text = self.viewModel.currentWeatherViewData.weatherState
    }
}

// MARK: - Listeners
extension MainIpadViewController {
    private func addListeners() {
        viewModel.shouldShowLoadingAnimation
            .receive(on: DispatchQueue.main)
            .sink { show in
            show ? LoadingView.show() : LoadingView.hide()
        }.store(in: &cancellables)
        
        viewModel.shouldUpdateTableView
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.updateWeatherInfoUI()
        }.store(in: &cancellables)
    }
}
