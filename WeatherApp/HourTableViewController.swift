//
//  Child2ViewController.swift
//  WeatherApp
//
//  Created by Mine Rala on 13.07.2021.
//

import UIKit
import Combine

class HourTableViewController: UIViewController {

    private var viewModel: MainViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet var hourView: UIView!
    @IBOutlet weak var hourTableView: UITableView!

}

// MARK: - Public
extension HourTableViewController {
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.hourTableView.reloadData()
        
    }
}

//MARK: - Set Up Uı
extension HourTableViewController {
    private func setUpUI() {
        hourView.layer.cornerRadius = 10
        
        hourTableView.register(UINib(nibName: "IpadHoursTableViewCell", bundle: nil), forCellReuseIdentifier: "IpadHoursTableViewCell")
        hourTableView.delegate = self
        hourTableView.dataSource = self
        hourTableView.tableFooterView = UIView()
        
        self.view.backgroundColor = .clear
        hourTableView.backgroundColor = .clear
        hourView.backgroundColor = .clear
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
        let current = viewModel!.currentWeatherHourlyDataViews[indexPath.row]
        cell.configureCell(currentForecast: current)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let current = viewModel!.currentWeatherHourlyDataViews[indexPath.row]
        guard current.isSelected == false else { return }
        viewModel?.initialize(with: current.date)
    }

}

// MARK: - Listeners
extension HourTableViewController {
    private func addListeners() {
        guard let viewModel = viewModel else { return }
        self.cancellables.forEach { $0.cancel() }
        viewModel.shouldUpdateTableView
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.hourTableView.reloadData()
                self.hourTableView.layoutIfNeeded()
        }.store(in: &cancellables)
    }
}
