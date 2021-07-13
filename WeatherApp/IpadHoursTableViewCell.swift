//
//  IpadHoursTableViewCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 13.07.2021.
//

import UIKit

class IpadHoursTableViewCell: UITableViewCell {

    @IBOutlet weak var hourView: UIView!
    
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
    
}
