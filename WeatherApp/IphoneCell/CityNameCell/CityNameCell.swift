//
//  CityNameCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 30.06.2021.
//

import UIKit

class CityNameCell: UITableViewCell {
    @IBOutlet weak var lblCity: UILabel!
}

//MARK: -Set up uı
extension CityNameCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblCity.font = C.Font.demiBold.font(with: 20)
        self.selectionStyle = .none
    }
}
//MARK: -Configure Cell
extension CityNameCell {
    func configureCell(viewModel: MainViewModel) {
        self.lblCity.textColor = C.Color.cityInfoTitleColor
        guard let currentWeatherViewData = viewModel.currentWeatherViewData else {
            self.lblCity.text = "-"
            return
        }
        self.lblCity.text = currentWeatherViewData.locationText
    }
}
