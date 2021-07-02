//
//  WeatherHourlyCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 30.06.2021.
//

import UIKit

class WeatherHourlyCell: UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    @IBOutlet private weak var collectionViewHourlyWeather: UICollectionView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionViewHourlyWeather.register(UINib(nibName: "WeatherHourCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherHourCollectionViewCell")
        self.collectionViewHourlyWeather.delegate = self
        self.collectionViewHourlyWeather.dataSource = self

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherHourCollectionViewCell", for: indexPath) as! WeatherHourCollectionViewCell
//        let model = self.dailyModel.listForecastData[indexPath.row]
//        cell.update(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64, height: 122)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func configureCell(_ viewModel: MainViewModel) {
        self.collectionViewHourlyWeather.reloadData()
    }
    
}
