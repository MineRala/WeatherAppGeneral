//
//  WeatherDataCollectionView.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 13.07.2021.
//

import Foundation
import UIKit
import Combine

class WeatherDataCollectionView: UIViewController {
    @IBOutlet weak var collectionViewWeatherData: UICollectionView!
    
    private var viewModel: MainViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}

// MARK: - Public
extension WeatherDataCollectionView {
    func setViewModel(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
        addListeners()
    }
}

// MARK: - LifeCycle
extension WeatherDataCollectionView {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.collectionViewWeatherData.reloadData()
    }
}

// MARK: - Set Up UI
extension WeatherDataCollectionView {
    private func setUpUI() {
        collectionViewWeatherData.layer.cornerRadius = 10
        collectionViewWeatherData.register(UINib(nibName: "WeatherDataCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherDataCollectionViewCell")
        collectionViewWeatherData.delegate = self
        collectionViewWeatherData.dataSource = self
        self.view.backgroundColor = .clear
        collectionViewWeatherData.backgroundColor = .clear
    }
}

// MARK: - Listeners
extension WeatherDataCollectionView {
    private func addListeners() {
        guard let viewModel = viewModel else { return }
        cancellables.forEach { $0.cancel() }
        viewModel.shouldUpdateTableView
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.collectionViewWeatherData.reloadData()
                self.collectionViewWeatherData.layoutIfNeeded()
        }.store(in: &cancellables)
    }
}

// MARK: - CollectionView
extension WeatherDataCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let vm = viewModel, let _ = vm.currentWeatherViewData else { return 0 }
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let vm = viewModel, let currentWeatherViewData = vm.currentWeatherViewData else { fatalError() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherDataCollectionViewCell", for: indexPath) as! WeatherDataCollectionViewCell
       
        switch indexPath.row {
        case 0:
            let title = "Wind Speed"
            let value = currentWeatherViewData.windSpeedValue
            cell.configureCell(title: title, value: value)
            
        case 1:
            let title = "Pressure"
            let value = currentWeatherViewData.pressureValue
            cell.configureCell(title: title, value: value)
            
        case 2:
            let title = "Humidity"
            let value = currentWeatherViewData.humidityValue
            cell.configureCell(title: title, value: value)
            
        case 3:
            let title = "Wind Degree"
            let value = currentWeatherViewData.windDegreeValue
            cell.configureCell(title: title, value: value)
       
        case 4:
            let title = "Sunrise"
            let value = currentWeatherViewData.sunriseValue
            cell.configureCell(title: title, value: value)
            
        case 5:
            let title = "Sunset"
            let value = currentWeatherViewData.sunsetValue
            cell.configureCell(title: title, value: value)
            
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3  , height: collectionView.frame.size.height / 2)
    }
}
