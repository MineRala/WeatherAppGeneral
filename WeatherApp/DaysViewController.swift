//
//  DaysViewController.swift
//  WeatherApp
//
//  Created by Mine Rala on 2.07.2021.
//

import UIKit
import Combine

class DaysViewController: UIViewController {

    @IBOutlet weak var tableViewDays: UITableView!
    @IBOutlet weak var DaysView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var labelNext5Days: UILabel!
    
    private var viewModel: MainViewModel!
    private var cancellables = Set<AnyCancellable>()
}

// MARK: - Lifecycle
extension DaysViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

// MARK: - Actions
extension DaysViewController {
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Public
extension DaysViewController {
    func setViewModel(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
        addListeners()
    }
}

//MARK: - Set up UI
extension DaysViewController {
    private func setUpUI() {
        self.DaysView.backgroundColor = C.Color.daysViewColor
        self.backButton.tintColor = C.Color.backButtonColor
        self.labelNext5Days.tintColor = C.Color.labelNext5DaysColor
        self.labelNext5Days.font = C.Font.demiBold.font(with: 20)
        
        tableViewDays.register(UINib(nibName: "DaysTableViewCell", bundle: nil), forCellReuseIdentifier: "DaysTableViewCell")
        tableViewDays.delegate = self
        tableViewDays.dataSource = self
        }
    }
    
 //MARK: - Table View
extension DaysViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrListViewData.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DaysTableViewCell",for: indexPath)as! DaysTableViewCell
        let viewDataItem = self.viewModel.arrListViewData[indexPath.row + 1]
        cell.configureCell(with: viewDataItem)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.viewModel.arrListViewData[indexPath.row + 1]
        let dependency = MainViewControllerDependency(viewModel: self.viewModel, selectedDate: model.date, isFromDaysViewController: true, nameOfTheDay: model.date.nameOfTheDay)
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController") as! MainViewController
        viewController.setDependency(dependency)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Add Listeners
extension DaysViewController {
    private func addListeners() {
        viewModel.shouldUpdateTableView.receive(on: DispatchQueue.main).sink { _ in
            guard let table = self.tableViewDays else { return }
            table.reloadData()
        }.store(in: &cancellables)
    }
}

