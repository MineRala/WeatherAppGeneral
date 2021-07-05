//
//  NextDayCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 30.06.2021.
//

import UIKit

class NextDayCell: UITableViewCell {

    @IBOutlet weak var btnText: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.btnText.tintColor = C.Color.nextDaysColor
    }
  
    
    @IBAction func btnNextDays(_ sender: Any) {
        
    }
    
}
