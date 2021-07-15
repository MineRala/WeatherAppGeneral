//
//  IpadHoursTableViewCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 13.07.2021.
//

import UIKit

class IpadHoursTableViewCell: UITableViewCell {

    @IBOutlet weak var hourView: UIView!
    @IBOutlet weak var lblDegree: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    private var currentTimeForecast: WeatherHourlyDataView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        hourView.layer.borderColor = #colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1)
        hourView.layer.borderWidth = 1
        hourView.layer.cornerRadius = 31
      
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(currentForecast: WeatherHourlyDataView) {
        
        self.currentTimeForecast = currentForecast
        
        if currentForecast.isSelected {
            
            self.hourView.backgroundColor = C.Color.ipadChosenDayCellBackgroundColor
            self.imgIcon.tintColor = C.Color.ipadChosenDayCellTextColor
            self.lblDegree.textColor = C.Color.ipadChosenDayCellTextColor
            self.lblHour.textColor = C.Color.ipadChosenDayCellTextColor
            
            
        } else {
            self.hourView.backgroundColor = C.Color.ipadHourTableViewCellBackgroundColor
           // self.backgroundColor = .clear
            self.lblHour.textColor = C.Color.ipadHourTableViewCellTextColor
            self.lblDegree.textColor = C.Color.ipadHourTableViewCellTextColor
            self.imgIcon.tintColor = C.Color.ipadHourTableViewCellImageColor
            
        }
        self.lblHour.text = currentForecast.timeText
        self.imgIcon.image = UIImage(systemName: currentForecast.icon)
        self.lblDegree.text = currentForecast.degreeText
    }
    
    
}
