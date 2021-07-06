//
//  CityNameCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 30.06.2021.
//

import UIKit

class CityNameCell: UITableViewCell {

    @IBOutlet weak var cityNameContentView: UIView!
    @IBOutlet weak var lblCity: UILabel!
    
    private var viewModel: MainViewModel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lblCity.font = C.Font.demiBold.font(with: 20)
       
    }
    
    func configureCell(viewModel: MainViewModel) {
        self.lblCity.textColor = C.Color.cityInfoTitleColor
        self.cityNameContentView.backgroundColor = C.Color.cityNameCVColor
        self.viewModel = viewModel
        self.lblCity.text = "\(viewModel.cityName), \(viewModel.countryName)"
    }
    
}
