//
//  NextDayCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 30.06.2021.
//

import UIKit

class NextDayCell: UITableViewCell {

    @IBOutlet weak var nextDayContentView: UIView!
    @IBOutlet weak var btnText: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.btnText.tintColor = C.Color.nextDaysColor
        self.nextDayContentView.backgroundColor = C.Color.nextDaysCVColor
        
    }
  
    @IBAction func btnNextDays(_ sender: Any) {
        
    }
    
}
