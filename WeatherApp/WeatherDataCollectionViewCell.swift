//
//  WeatherDataCollectionViewCell.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 13.07.2021.
//

import UIKit

class WeatherDataCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewContent: UIView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewContent.backgroundColor = C.Color.ipadCollectionViewBackgroundColor
        self.lblTitle.textColor = C.Color.ipadCollectionViewInfoColor
        self.lblValue.textColor = C.Color.ipadCollectionViewInfoValueColor
    
        
    }
    
    func configureCell(title: String, value: String) {
        self.lblTitle.text = title
        self.lblValue.text = value
    }

}
