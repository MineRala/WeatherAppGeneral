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
    var viewModel: MainViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Set up uı
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
        cell.configureCell( viewModel: viewModel)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }
}


