//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 2.07.2021.
//

import Foundation
import SwiftLocation
import CoreLocation
import Combine

// MARK: - Main View Model {Class}
class MainViewModel {
    
    private let dataLayer = DataLayer()
    
    var currentWeatherViewData: WeatherViewDataModel? {
        return self.createCurrentWeatherVDM()
    }
    
    var currentWeatherHourlyDataViews: [WeatherHourlyViewDataModel] {
        return self.createWeatherHourlyVDM()
    }
    
    var arrListViewData: [ListViewDataModel] {
        return self.createListViewDataModel()
    }
    
    var arrTableViewItems: [WeatherTableItem] {
        return _arrTableViewItems
    }
    
    private var _currentWeatherViewData: WeatherViewDataModel?
    private var _currentWeatherHourlyDataViews: [WeatherHourlyViewDataModel] = []
    private var _arrListViewData: [ListViewDataModel] = []
    private var _arrTableViewItems: [WeatherTableItem] = []
    private var selectedDate: Date? = nil

    private(set) var shouldUpdateTableView = PassthroughSubject<Void, Never>()
    private(set) var shouldShowAlertViewForError = PassthroughSubject<WeatherAppError, Never>()
    private(set) var shouldNavigateToDaysViewController = PassthroughSubject<Void, Never>()
    private(set) var shouldShowLoadingAnimation = CurrentValueSubject<Bool, Never>(false)
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
    }
    
    deinit {
        self.cancellables.forEach { $0.cancel() }
    }
}

// MARK: - Public
extension MainViewModel {
    
    @objc func initialize(with selectedDate: Date? = nil) {
       
        if self.selectedDate != selectedDate {
            self.selectedDate = selectedDate
            self._arrListViewData = []
            self._currentWeatherHourlyDataViews = []
            self._currentWeatherViewData = nil
            self.shouldUpdateTableView.send()
        }
        self._arrTableViewItems = [.cityInfo, .weatherInfo, .nextDay, .hourlyInfo, .sunDetail, .windDetail]
       
        let publisher = self.initializeDataLayerIfNeeded()
    
        self.shouldShowLoadingAnimation.send(true)
        self.shouldUpdateTableView.send()
        publisher.sink { err in
            self.shouldUpdateTableView.send()
            self.shouldShowLoadingAnimation.send(false)
        }.store(in: &cancellables)
    }
    
    func nextFiveDaysDidTapped() {
        self.shouldNavigateToDaysViewController.send()
    }
    
    func reset() {
        self.dataLayer.reset()
        self._arrListViewData = []
        self._currentWeatherHourlyDataViews = []
        self._currentWeatherViewData = nil
    }
}

// MARK: - Initialize
extension MainViewModel {
    private func initializeDataLayerIfNeeded() -> AnyPublisher<WeatherAppError?, Never> {
        guard let _ = self.dataLayer.weatherModel else {
            return self.dataLayer.initialize()
        }
        return Just(nil).eraseToAnyPublisher()
    }
}

// MARK: - Creators
extension MainViewModel {
    private func createCurrentWeatherVDM() -> WeatherViewDataModel? {
        if let data = _currentWeatherViewData { return data }
        let date = selectedDate ?? Date()
        guard let listItem = self.dataLayer.listItem(from: date) else { return nil }
        guard let weatherModel = self.dataLayer.weatherModel else { return nil }
        guard let city = weatherModel.city else { return nil }
        _currentWeatherViewData = WeatherVDMConverters.weatherViewDataModel(from: listItem, city: city)
        return _currentWeatherViewData
    }
    
    private func createWeatherHourlyVDM() -> [WeatherHourlyViewDataModel] {
        if _currentWeatherHourlyDataViews.count > 0 { return _currentWeatherHourlyDataViews }
        let date = selectedDate ?? Date()
        let listItems = dataLayer.listItems(from: date)
        return WeatherVDMConverters.weatherHourlyViewDataModel(from: listItems, selectedDate: date)
    }
    
    private func createListViewDataModel() -> [ListViewDataModel] {
        if _arrListViewData.count > 0 { return _arrListViewData }
        let listItems = dataLayer.dailyWeatherListItems()
        let date = selectedDate ?? Date()
        return WeatherVDMConverters.listViewDataModels(from: listItems, selectedDate: date)
    }
    
}
