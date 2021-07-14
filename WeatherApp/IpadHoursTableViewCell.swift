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
    
    private var currentTimeForecast: List!
    
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
    
    
    func configureCell(currentForecast: List) {
        
        self.currentTimeForecast = currentForecast
        self.lblHour.text = self.currentTimeForecast.dateWithFormat()
        self.imgIcon.image = UIImage(systemName:self.currentTimeForecast.weatherIcon())
        self.lblDegree.text = currentForecast.degreeValue()
    }
    
    
}
