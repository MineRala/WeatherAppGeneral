//
//  WeatherDetailsInfoCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 30.06.2021.
//

import UIKit

class WeatherDetailsInfoCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet weak var weatherDetailsInfoCellContentView: UIView!
    @IBOutlet private weak var collectionViewDetails: UICollectionView!
    
    private var viewModel: MainViewModel!
    private var cellType: DetailIInfoCellType = .top
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionViewDetails.register(UINib(nibName: "WeatherDetailInfoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "WeatherDetailInfoCollectionCell")
        self.collectionViewDetails.delegate = self
        self.collectionViewDetails.dataSource = self
        self.collectionViewDetails.reloadData()
        
        //Shadow Opacitiy
        weatherDetailsInfoCellContentView.layer.shadowOpacity = 1
        weatherDetailsInfoCellContentView.layer.shadowRadius = 50
        weatherDetailsInfoCellContentView.layer.shadowColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        weatherDetailsInfoCellContentView.layer.shouldRasterize = true
      
        
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherDetailInfoCollectionCell", for: indexPath) as! WeatherDetailInfoCollectionCell
        
        switch indexPath.row {
        case 0:
            let title = cellType == .top ? "Sunrise" : "Wind Speed"
            let value = cellType == .top ? viewModel.sunriseValue : viewModel.windSpeedValue
            cell.configureCell(title: title, value: value)
            
        case 1:
            let title = cellType == .top ? "Sunset" : "Wind Degree"
            let value = cellType == .top ? viewModel.sunsetValue : viewModel.windDegreeValue
            cell.configureCell(title: title, value: value)
            
        case 2:
            let title = cellType == .top ? "Ground Level" : "Pressure"
            let value = cellType == .top ? viewModel.groundLevelValue : viewModel.pressureValue
            cell.configureCell(title: title, value: value)
            
        case 3:
            let title = cellType == .top ? "Sea Level" : "Humudity"
            let value = cellType == .top ? viewModel.seeLevelValue : viewModel.humudityVaalue
            cell.configureCell(title: title, value: value)
            
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2 - 32, height: 84)
    }
    
    func configureCell(viewModel: MainViewModel, cellType: DetailIInfoCellType) {
        self.weatherDetailsInfoCellContentView.backgroundColor = C.Color.weatherDetailsInfoCellCVColor
        self.collectionViewDetails.backgroundColor = C.Color.weatherDetailsInfoCellCVColor
        self.viewModel = viewModel
        self.cellType = cellType
        self.collectionViewDetails.reloadData()
        
    }
    
    
}
