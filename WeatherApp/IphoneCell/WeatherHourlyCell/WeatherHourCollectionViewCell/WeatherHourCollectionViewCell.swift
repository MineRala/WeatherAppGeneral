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
    
}

//MARK: -Set up uı
    extension WeatherHourCollectionViewCell {
        override func awakeFromNib() {
            super.awakeFromNib()
            collectionContentView.layer.cornerRadius = 32
            collectionContentView.layer.borderWidth = 1
            collectionContentView.layer.borderColor = #colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1).cgColor
            viewImageContentArea.layer.cornerRadius = 18
            
            self.labelDegree.font = C.Font.book.font(with: 14)
            self.labelTime.font = C.Font.book.font(with: 14)
        }
}

//MARK: -Configure Cell
    extension WeatherHourCollectionViewCell{
        func configureCell(currentForecast: WeatherHourlyViewDataModel) {
            
            self.labelTime.text = currentForecast.timeText
            self.ImageIcon.image = UIImage(systemName: currentForecast.icon)
            self.labelDegree.text = currentForecast.degreeText
            
            self.collectionContentView.backgroundColor = currentForecast.isSelected ? C.Color.hourlCollectionViewCellSelectedBgColor : .clear
            self.labelDegree.textColor = currentForecast.isSelected ? C.Color.hourlCollectionViewCellSelectedDegreeColor : C.Color.labelDegreeColor
            self.labelTime.textColor = currentForecast.isSelected ? C.Color.hourlCollectionViewCellSelectedTimeColor : C.Color.labelTimeColor
            self.ImageIcon.tintColor = currentForecast.isSelected ? C.Color.hourlCollectionViewCellSelectedIconColor : C.Color.imageIconColor
            self.viewImageContentArea.backgroundColor = currentForecast.isSelected ? C.Color.hourlCollectionViewCellSelectedEllipsColor : C.Color.imageContentArea
        }
}
