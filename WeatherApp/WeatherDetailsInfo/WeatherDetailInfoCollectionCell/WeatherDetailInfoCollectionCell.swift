//
//  WeatherDetailInfoCollectionCell.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 2.07.2021.
//

import UIKit

class WeatherDetailInfoCollectionCell: UICollectionViewCell {

    @IBOutlet weak var weatherDetailInfoCollectionCell: UIView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblValue: UILabel!
}

//MARK: -Set up uı
    extension WeatherDetailInfoCollectionCell {
        override func awakeFromNib() {
            super.awakeFromNib()
            self.lblTitle.font = C.Font.demiBold.font(with: 16)
            self.lblValue.font = C.Font.demiBold.font(with: 22)

        }
}
    
//MARK: -Configure Cell
    extension WeatherDetailInfoCollectionCell {
        func configureCell(title: String, value: String) {
            
            self.lblTitle.textColor = C.Color.lblTitleColor
            self.lblValue.textColor = C.Color.lblValueColor
           
            self.lblTitle.text = title
            self.lblValue.text = value
        }
}
   
