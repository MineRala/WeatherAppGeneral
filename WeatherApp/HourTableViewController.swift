//
//  Child2ViewController.swift
//  WeatherApp
//
//  Created by Mine Rala on 13.07.2021.
//

import UIKit

class HourTableViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    var viewModel: MainViewModel!
    
    @IBOutlet var hourView: UIView!
    
    @IBOutlet weak var hourTableView: UITableView!
    
    override func viewDidLoad() {
       super.viewDidLoad()
      
        hourTableView.register(UINib(nibName: "IpadHoursTableViewCell", bundle: nil), forCellReuseIdentifier: "IpadHoursTableViewCell")
        hourTableView.delegate = self
        hourTableView.dataSource = self
        hourTableView.allowsSelection = false
        hourTableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IpadHoursTableViewCell", for: indexPath) as! IpadHoursTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
}

// MARK: - Public
extension HourTableViewController: IpadChildViewControllerProtocol {
    func setViewModel(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
        
    }
    
  
}


