//
//  WeatherHourCollectionViewCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 1.07.2021.
//

import UIKit

class WeatherHourCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelDegree: UILabel!
    @IBOutlet weak var ImageIcon: UIImageView!
    @IBOutlet weak var labelTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
//    static func nib() -> UINib {
//        return UINib(nibName: "WeatherHourlyCollectionViewCell", bundle: nil)
//    }
//    

    @IBAction func WeatherHourlyCellClicked(_ sender: Any) {
    }
}
