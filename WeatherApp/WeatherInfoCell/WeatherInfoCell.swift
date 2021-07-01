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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
