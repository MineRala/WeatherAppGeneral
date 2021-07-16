//
//  WeatherHourlyCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 30.06.2021.
//

import UIKit

class WeatherHourlyCell: UITableViewCell {
  
    @IBOutlet weak var weatherHourlyCellContentView: UIView!
    @IBOutlet private weak var collectionViewHourlyWeather: UICollectionView!
  
    private var viewModel: MainViewModel?
}

//MARK: -Set up uı
extension WeatherHourlyCell {
        override func awakeFromNib() {
            super.awakeFromNib()
            self.backgroundColor = .clear
            self.selectionStyle = .none
            self.collectionViewHourlyWeather.register(UINib(nibName: "WeatherHourCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherHourCollectionViewCell")
            self.collectionViewHourlyWeather.delegate = self
            self.collectionViewHourlyWeather.dataSource = self
            self.weatherHourlyCellContentView.layer.cornerRadius = 8
            self.weatherHourlyCellContentView.addItemShadow()
            self.collectionViewHourlyWeather.backgroundColor = .clear
    }
}

//MARK: -Collection View
extension WeatherHourlyCell:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.currentWeatherHourlyDataViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherHourCollectionViewCell", for: indexPath) as! WeatherHourCollectionViewCell
        let currentForecast = viewModel!.currentWeatherHourlyDataViews[indexPath.row]
        cell.configureCell(currentForecast: currentForecast)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64, height: 122)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentForecast = viewModel!.currentWeatherHourlyDataViews[indexPath.row]
        self.viewModel!.initialize(with: currentForecast.date)
    }
}

//MARK: -Configure Cell
extension WeatherHourlyCell {
    func configureCell(_ viewModel: MainViewModel) {
        self.weatherHourlyCellContentView.backgroundColor = C.Color.collectionViewHourlyWeatherColor
        self.viewModel = viewModel
        self.collectionViewHourlyWeather.reloadData()
    }
}
