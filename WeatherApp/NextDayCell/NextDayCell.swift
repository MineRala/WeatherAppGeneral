//
//  NextDayCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 30.06.2021.
//

import UIKit

class NextDayCell: UITableViewCell {

   
    @IBOutlet weak var btnText: UIButton!
    
    private var viewModel: MainViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
  
    func  configureCell(_ viewModel : MainViewModel)  {
        self.viewModel = viewModel
        self.btnText.tintColor = C.Color.nextDaysColor
        
    }
    
    @IBAction func btnNextDays(_ sender: Any) {
        self.viewModel.nextFiveDaysDidTapped()
    }
    
}
