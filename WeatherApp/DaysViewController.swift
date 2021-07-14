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
        viewModel.initializeListViewItems()
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DaysTableViewCell",for: indexPath)as! DaysTableViewCell
        let viewDataItem = self.viewModel.arrListViewData[indexPath.row]
        cell.configureCell(with: viewDataItem)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
        print("\(indexPath.row) clicked")
    }
}

// MARK: - Add Listeners
extension DaysViewController {
    private func addListeners() {
        viewModel.shouldUpdateTableView.receive(on: DispatchQueue.main).sink { _ in
            self.tableViewDays.reloadData()
        }.store(in: &cancellables)
    }
}

