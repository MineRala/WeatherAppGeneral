//
//  MainIpadViewController.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 5.07.2021.
//

import UIKit
import Combine

class MainIpadViewController: UIViewController {
    
     var childVC: ChildVC!
    @IBOutlet weak var viewContent: UIView!
    private var cancellables = Set<AnyCancellable>()
}

// MARK: - Lifecycle
extension MainIpadViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        self.childVC = self.children.compactMap {
            return $0 as? ChildVC
        }.first
      
        print(self.childVC)
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        print(documentsDirectory)
        */
        
        Network.shared.networkStatus.receive(on: DispatchQueue.main).sink { status in
            print("Current Status: \(status)")
        }.store(in: &cancellables)
        
    }
}
