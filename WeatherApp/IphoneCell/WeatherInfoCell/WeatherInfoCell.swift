//
//  WeatherInfoCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 30.06.2021.
//

import UIKit

class WeatherInfoCell: UITableViewCell {

    @IBOutlet weak var labelState: UILabel!
    @IBOutlet weak var labelDegree: UILabel!
    @IBOutlet weak var ImageIcon: UIImageView!
    @IBOutlet weak var labelDc: UILabel!
    
    private var viewModel: MainViewModel!
}

//MARK: -Set up uı
 extension WeatherInfoCell {
        override func awakeFromNib() {
            super.awakeFromNib()
            
            self.selectionStyle = .none
            self.labelDegree.font = C.Font.book.font(with: 111)
            self.labelDc.font = C.Font.bold.font(with: 26)
            self.labelState.font = C.Font.light.font(with: 26)
        }

}
    
//MARK: -Configure Cell
    extension WeatherInfoCell{
        func configureCell(_ viewModel: MainViewModel) {
            self.viewModel = viewModel
            
            self.labelState.text = viewModel.currentWeatherViewData.weatherState
            self.labelDegree.text = viewModel.currentWeatherViewData.weatherDegree
            self.ImageIcon.image = UIImage(systemName: viewModel.currentWeatherViewData.weatherIcon)

            self.labelDegree.textColor = C.Color.labelDegreeInfoColor
            self.labelDc.textColor = C.Color.labelDcColor
            self.labelState.textColor = C.Color.labelStateColor
        }
}
    

