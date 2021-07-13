//
//  MainIpadViewController.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 5.07.2021.
//

import UIKit
import Combine

class MainIpadViewController: UIViewController {
    
    @IBOutlet weak var dayTableView: UIView!
    var dayTableVC: DayTableViewController!
     var hourTableVc: HourTableViewController!
    
    @IBOutlet weak var hourTableView: UIView!
    @IBOutlet weak var hourTable: HourTableViewController!
    @IBOutlet weak var viewContent: UIView!
    private var cancellables = Set<AnyCancellable>()
    
}

// MARK: - Lifecycle
extension MainIpadViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dayTableVC = self.children.compactMap({ (child) -> DayTableViewController? in
            guard let viewController = child as? DayTableViewController else{return nil}
            return viewController
        }).first
        
        self.hourTableVc = self.children.compactMap({ (child) -> HourTableViewController? in
            guard let viewController = child as? HourTableViewController else{return nil}
            return viewController
        }).first
        
    }
}
