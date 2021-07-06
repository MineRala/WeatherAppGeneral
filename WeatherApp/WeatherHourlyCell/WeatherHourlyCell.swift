//
//  WeatherHourlyCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 30.06.2021.
//

import UIKit

class WeatherHourlyCell: UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    @IBOutlet weak var weatherHourlyCellContentView: UIView!
    @IBOutlet private weak var collectionViewHourlyWeather: UICollectionView!
  
    private var viewModel: MainViewModel!
    private var todayWeatherList: [List] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionViewHourlyWeather.register(UINib(nibName: "WeatherHourCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherHourCollectionViewCell")
        self.collectionViewHourlyWeather.delegate = self
        self.collectionViewHourlyWeather.dataSource = self
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayWeatherList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherHourCollectionViewCell", for: indexPath) as! WeatherHourCollectionViewCell
        let currentForecast = todayWeatherList[indexPath.row]
        let isChosen = viewModel.isCurrentForecastTimeModel(timeForecast: currentForecast)
        cell.configureCell(currentForecast: todayWeatherList[indexPath.row], isChosen: isChosen)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64, height: 122)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentForecast = todayWeatherList[indexPath.row]
        print("Chosen : \(currentForecast) at index: \(indexPath.row)")
        self.viewModel.updateCurrentWeather(currentForecast)
    }
    
    func configureCell(_ viewModel: MainViewModel) {
        self.collectionViewHourlyWeather.backgroundColor = C.Color.collectionViewHourlyWeatherColor
        self.todayWeatherList = viewModel.getTodayForecastList()
        self.viewModel = viewModel
        self.collectionViewHourlyWeather.reloadData()
    }
    
}
