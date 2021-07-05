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
    
    private var currentTimeForecast: List!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionContentView.layer.cornerRadius = 32
        collectionContentView.layer.borderWidth = 1
        collectionContentView.layer.borderColor = #colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1).cgColor
        viewImageContentArea.layer.cornerRadius = 18
        
        self.labelDegree.font = C.Font.book.font(with: 14)
        self.labelDegree.textColor = C.Color.labelDegreeColor
        self.ImageIcon.tintColor = C.Color.imageIconColor
        self.labelTime.font = C.Font.book.font(with: 14)
        self.labelTime.textColor = C.Color.labelTimeColor
        self.viewImageContentArea.backgroundColor = C.Color.imageContentArea
        
    }
    

    func configureCell(currentForecast: List, isChosen: Bool) {
        self.currentTimeForecast = currentForecast
        self.labelTime.text = self.currentTimeForecast.dateWithFormat()
        self.ImageIcon.image = UIImage(systemName: self.currentTimeForecast.weatherIcon())
        self.labelDegree.text = currentForecast.degreeValue()
        self.collectionContentView.backgroundColor = isChosen ? C.Color.hourlCollectionViewCellSelectedBgColor : C.Color.imageIconColor
        self.labelDegree.textColor = isChosen ? C.Color.hourlCollectionViewCellSelectedDegreeColor : C.Color.labelDegreeColor
        self.labelTime.textColor = isChosen ? C.Color.hourlCollectionViewCellSelectedTimeColor : C.Color.labelTimeColor
        self.ImageIcon.tintColor = isChosen ? C.Color.hourlCollectionViewCellSelectedIconColor : C.Color.imageIconColor
        self.viewImageContentArea.backgroundColor = isChosen ? C.Color.hourlCollectionViewCellSelectedEllipsColor : C.Color.imageContentArea
    }
}
