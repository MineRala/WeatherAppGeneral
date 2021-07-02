//
//  CityNameCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 30.06.2021.
//

import UIKit

class CityNameCell: UITableViewCell {

    @IBOutlet weak var lblCity: UILabel!
    
    private var viewModel: MainViewModel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
      
      
    }
    
    func configureCell(viewModel: MainViewModel) {
        self.viewModel = viewModel
        self.lblCity.text = "\(viewModel.cityName), \(viewModel.countryName)"
    }
    
}
