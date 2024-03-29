//
//  IpadDaysTableViewCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 13.07.2021.
//

import UIKit

class IpadDaysTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblDegree: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with item: ListViewDataModel) {
       
        self.lblDate.text = item.dayAndMonth
        self.lblDay.text = item.dayName
        self.lblDegree.text = item.degree
        
        if item.isSelected {
            self.backgroundColor = C.Color.ipadChosenDayCellBackgroundColor
            self.lblDay.textColor = C.Color.ipadChosenDayCellTextColor
            self.lblDegree.textColor = C.Color.ipadChosenDayCellTextColor
            self.lblDate.textColor = C.Color.ipadChosenDayCellTextColor
        } else {
            self.backgroundColor = .clear
            self.lblDay.textColor = C.Color.ipadDayCellDayTextColor
            self.lblDate.textColor = C.Color.ipadDayCellDateTextColor
            self.lblDegree.textColor = C.Color.ipadDayCellDegreeTextColor
        }
    }
}
