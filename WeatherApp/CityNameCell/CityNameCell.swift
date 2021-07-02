//
//  CityNameCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 30.06.2021.
//

import UIKit

class CityNameCell: UITableViewCell {

    @IBOutlet weak var lblCity: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }
    
    func configureCell(cityName: String, countryName: String) {
        self.lblCity.text = "\(cityName), \(countryName)"
    }
    
}
