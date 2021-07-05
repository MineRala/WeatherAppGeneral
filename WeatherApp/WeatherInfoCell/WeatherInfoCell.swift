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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.labelDegree.font = C.Font.book.font(with: 111)
        self.labelDegree.textColor = C.Color.labelDegreeInfoColor
        self.labelDc.font = C.Font.bold.font(with: 26)
        self.labelDc.textColor = C.Color.labelDcColor
        self.labelState.font = C.Font.light.font(with: 26)
        self.labelState.textColor = C.Color.labelStateColor
        
        
        
    }

    func configureCell(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
        
        self.labelState.text = viewModel.weatherState
        self.labelDegree.text = viewModel.weatherDegree
        self.ImageIcon.image = UIImage(systemName: viewModel.weatherIcon)
        // TODO: icon identifier to icon
    }
    
}
