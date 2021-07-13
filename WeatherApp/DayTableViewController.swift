//
//  ChildVC.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 5.07.2021.
//

import UIKit

class DayTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
  
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var dayTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dayTableView.register(UINib(nibName: "IpadDaysTableViewCell", bundle: nil), forCellReuseIdentifier: "IpadDaysTableViewCell")
        dayTableView.delegate = self
        dayTableView.dataSource = self
        dayTableView.allowsSelection = false
        dayTableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IpadDaysTableViewCell", for: indexPath) as! IpadDaysTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

}
