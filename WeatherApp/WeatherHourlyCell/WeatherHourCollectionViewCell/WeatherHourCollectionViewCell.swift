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
    @IBOutlet weak var viewImageContentArea: UIView!
    
    @IBOutlet weak var collectionContentView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionContentView.layer.cornerRadius = 32
        collectionContentView.layer.borderWidth = 1
        collectionContentView.layer.borderColor = #colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1).cgColor
        viewImageContentArea.layer.cornerRadius = 18
        
    }
    
//    static func nib() -> UINib {
//        return UINib(nibName: "WeatherHourlyCollectionViewCell", bundle: nil)
//    }
//    

    
}
