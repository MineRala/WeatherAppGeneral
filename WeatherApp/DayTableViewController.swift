//
//  ChildVC.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 5.07.2021.
//

import UIKit
import Combine

class DayTableViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var dayTableView: UITableView!
    
    private var viewModel: MainViewModel?
    private var cancellables = Set<AnyCancellable>()
}

// MARK: - Public
extension DayTableViewController {
    func setViewModel(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
        self.addListeners()
    }
}

//MARK: - Lifecycle
    extension DayTableViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            setUpUI()
            
        }
        
        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            self.dayTableView.reloadData()
            
        }
}

//MARK: - Set Up UI
extension DayTableViewController {
    private func setUpUI() {
        dayTableView.register(UINib(nibName: "IpadDaysTableViewCell", bundle: nil), forCellReuseIdentifier: "IpadDaysTableViewCell")
        dayTableView.delegate = self
        dayTableView.dataSource = self
       
        dayTableView.tableFooterView = UIView()
        self.view.backgroundColor = .clear
        dayTableView.backgroundColor = .clear
        
 }
}

//MARK: - Table View
extension DayTableViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.arrListViewData.count
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IpadDaysTableViewCell", for: indexPath) as! IpadDaysTableViewCell
        let viewDataItem = self.viewModel!.arrListViewData[indexPath.row]
        cell.configure(with: viewDataItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = viewModel!.arrListViewData[indexPath.row]
        guard selectedItem.isSelected == false else { return }
        viewModel?.initialize(with: selectedItem.date)
    }
}


//MARK: - Listeners
extension DayTableViewController {
    private func addListeners() {
        guard let viewModel = viewModel else { return }
        self.cancellables.forEach { $0.cancel() }
        viewModel.shouldUpdateTableView
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.dayTableView.reloadData()
                self.dayTableView.layoutIfNeeded()
        }.store(in: &cancellables)
    }
}
