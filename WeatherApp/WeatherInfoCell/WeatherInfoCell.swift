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
    
    private var viewModel: MainViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
        
        self.labelState.text = viewModel.weatherState
        self.labelDegree.text = viewModel.weatherDegree
        self.ImageIcon.image = UIImage(systemName: viewModel.weatherIcon)
        // TODO: icon identifier to icon
    }
    
}
