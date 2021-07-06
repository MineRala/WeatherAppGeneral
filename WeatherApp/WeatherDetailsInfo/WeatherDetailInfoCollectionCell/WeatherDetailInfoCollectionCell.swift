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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lblTitle.font = C.Font.demiBold.font(with: 16)
        self.lblTitle.textColor = C.Color.lblTitleColor
        self.lblValue.font = C.Font.demiBold.font(with: 22)
        self.lblValue.textColor = C.Color.lblValueColor
        self.weatherDetailInfoCollectionCell.backgroundColor = C.Color.weatherDetailInfoCollectionCellColor
        
    }
    
    func configureCell(title: String, value: String) {
        self.lblTitle.text = title
        self.lblValue.text = value
    }
}
