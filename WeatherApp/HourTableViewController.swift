//
//  Child2ViewController.swift
//  WeatherApp
//
//  Created by Mine Rala on 13.07.2021.
//

import UIKit
import Combine

class HourTableViewController: UIViewController {

    var viewModel: MainViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet var hourView: UIView!
    @IBOutlet weak var hourTableView: UITableView!

}


// MARK: - Public
extension HourTableViewController: IpadChildViewControllerProtocol {
    func setViewModel(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
        addListeners()
    }
}

//MARK: - Lifecycle
extension HourTableViewController {
    override func viewDidLoad() {
       super.viewDidLoad()
      setUpUI()
    }
}

//MARK: - Set Up Uı
extension HourTableViewController {
    private func setUpUI() {
        hourTableView.register(UINib(nibName: "IpadHoursTableViewCell", bundle: nil), forCellReuseIdentifier: "IpadHoursTableViewCell")
        hourTableView.delegate = self
        hourTableView.dataSource = self
        hourTableView.tableFooterView = UIView()
    }
}



//MARK: - Table View
extension HourTableViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.currentWeatherHourlyDataViews.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IpadHoursTableViewCell", for: indexPath) as! IpadHoursTableViewCell
        var current = viewModel.currentWeatherHourlyDataViews[indexPath.row]
        current.isSelected = viewModel.isCurrentForecastHourModel(hourText: current.timeText)
        cell.configureCell(currentForecast: current)
       // let currentForecast = todayWeatherList[indexPath.row]
        //cell.configureCell(currentForecast: currentForecast)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectCurrentHour(at: indexPath.row)
    }

}

// MARK: - Listeners
extension HourTableViewController {
    private func addListeners() {
        viewModel.shouldUpdateTableView
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.hourTableView.reloadData()
                self.hourTableView.layoutIfNeeded()
        }.store(in: &cancellables)
    }
}
