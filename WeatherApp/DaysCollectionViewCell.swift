//
//  DaysCollectionViewCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 12.07.2021.
//

import UIKit

class DaysCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelDetailNameValue: UILabel!
    @IBOutlet weak var labelDetailName: UILabel!

    override func awakeFromNib() {
      super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(title: String, value: String) {
       
        self.labelDetailName.text = title
        self.labelDetailNameValue.text = value
    }
}
