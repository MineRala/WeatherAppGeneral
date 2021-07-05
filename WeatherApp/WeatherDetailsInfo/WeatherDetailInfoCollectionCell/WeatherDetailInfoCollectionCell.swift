//
//  WeatherDetailInfoCollectionCell.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 2.07.2021.
//

import UIKit

class WeatherDetailInfoCollectionCell: UICollectionViewCell {

    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblValue: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(title: String, value: String) {
        self.lblTitle.text = title
        self.lblValue.text = value
    }
}
