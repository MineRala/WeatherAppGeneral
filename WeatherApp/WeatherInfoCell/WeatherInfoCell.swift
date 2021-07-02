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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(state: String, degree: Double, iconIdentifier: String) {
        self.labelState.text = state
        self.labelDegree.text = "\(degree)"
        // TODO: icon identifier to icon
    }
    
}
