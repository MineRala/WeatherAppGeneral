//
//  WeatherDetailsInfoCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 30.06.2021.
//

import UIKit

class WeatherDetailsInfoCell: UITableViewCell {

    @IBOutlet weak var weatherDetailsInfoCellContentView: UIView!
    @IBOutlet private weak var collectionViewDetails: UICollectionView!
    
    private var viewModel: MainViewModel!
    private var cellType: DetailIInfoCellType = .top
}

//MARK: -Set up uı
    extension WeatherDetailsInfoCell {
        override func awakeFromNib() {
            super.awakeFromNib()
            self.selectionStyle = .none
            self.collectionViewDetails.register(UINib(nibName: "WeatherDetailInfoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "WeatherDetailInfoCollectionCell")
            self.collectionViewDetails.delegate = self
            self.collectionViewDetails.dataSource = self
            self.collectionViewDetails.reloadData()
            
            weatherDetailsInfoCellContentView.layer.cornerRadius = 8
            weatherDetailsInfoCellContentView.addItemShadow()
        }
}

//MARK: -Collection View
extension WeatherDetailsInfoCell : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let currentWeatherViewData = viewModel.currentWeatherViewData else { fatalError() }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherDetailInfoCollectionCell", for: indexPath) as! WeatherDetailInfoCollectionCell
            
            switch indexPath.row {
            case 0:
                let title = cellType == .top ? "Sunrise" : "Wind Speed"
              
                let value = cellType == .top ? currentWeatherViewData.sunriseValue : currentWeatherViewData.windSpeedValue
                cell.configureCell(title: title, value: value)
                
            case 1:
                let title = cellType == .top ? "Sunset" : "Wind Degree"
                let value = cellType == .top ? currentWeatherViewData.sunsetValue : currentWeatherViewData.windDegreeValue
                cell.configureCell(title: title, value: value)
                
            case 2:
                let title = cellType == .top ? "Ground Level" : "Pressure"
                let value = cellType == .top ? currentWeatherViewData.groundLevelValue : currentWeatherViewData.pressureValue
                cell.configureCell(title: title, value: value)
                
            case 3:
                let title = cellType == .top ? "Sea Level" : "Humudity"
                let value = cellType == .top ? currentWeatherViewData.seeLevelValue : currentWeatherViewData.humidityValue
                cell.configureCell(title: title, value: value)
                
            default:
                break
            }
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.size.width / 2 - 32, height: 84)
        }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let currentWeatherViewData = viewModel.currentWeatherViewData else { return 0 }
        return 4
       }
}

//MARK: -Configure Cell
extension WeatherDetailsInfoCell {
    func configureCell(viewModel: MainViewModel, cellType: DetailIInfoCellType) {
        self.weatherDetailsInfoCellContentView.backgroundColor = C.Color.weatherDetailsInfoCellCVColor
        self.collectionViewDetails.backgroundColor = .clear
        self.viewModel = viewModel
        self.cellType = cellType
        self.collectionViewDetails.reloadData()
    }
}
