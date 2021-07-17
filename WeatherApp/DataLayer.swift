//
//  DataLayer.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 9.07.2021.
//

import Foundation
import Combine
import CoreLocation

class DataLayer {
    private var network: Network = Network.shared
    
    private let apiService = APIService()
    private let fileService = FileService()
    private let locationService = LocationService()

    private(set) var weatherModel: WeatherModel? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init(network: Network = Network.shared, weatherModel: WeatherModel? = nil) {
        self.network = network
        self.weatherModel = weatherModel
    }
    
}

// MARK: - Public
extension DataLayer {
    func reset() {
        self.weatherModel = nil 
    }
    
    func listItems(from selectedDate: Date) -> [List] {
        guard let model = weatherModel, let listArr = model.list  else { return [] }
        let selectedDayIdentifier = selectedDate.dateUniqueIdentifier
        return listArr.compactMap { item -> List? in
            guard item.date().dateUniqueIdentifier == selectedDayIdentifier else { return nil }
            return item
        }
    }
    
    func listItem(from selectedTime: Date) -> List? {
        guard let model = weatherModel, let listArr = model.list  else { return nil }
        let selectedDateIdentifier = selectedTime.fullDateUniqueIdentifier
        return listArr.first { item -> Bool in
            let identifer = item.date().fullDateUniqueIdentifier
            return identifer == selectedDateIdentifier
        } ?? listArr.first
    }
    
    func dailyWeatherListItems() -> [List] {
        guard let model = weatherModel, let listArr = model.list  else { return [] }
        var currentIdentifiers: [String] = []
        var tempListArr: [List] = []
        var listOfMidDayWeathers: [List] = []
      
        listArr.forEach { item in
            let uniqueIdentifier = item.date().dateUniqueIdentifier
            if !currentIdentifiers.contains(uniqueIdentifier) {
                if tempListArr.count > 0 {
                    let midDayWeather = tempListArr[tempListArr.count / 2]
                    listOfMidDayWeathers.append(midDayWeather)
                }
                currentIdentifiers.append(uniqueIdentifier)
                tempListArr = []
            }
            tempListArr.append(item)
        }
        
        if tempListArr.count > 0 {
            let midDayWeather = tempListArr[tempListArr.count / 2]
            listOfMidDayWeathers.append(midDayWeather)
        }
        return listOfMidDayWeathers
    }
    
    func initialize() -> AnyPublisher<WeatherAppError?, Never> {
        // Network Check
        if Network.shared.networkStatus.value == .offline {
            return self.fileService.readWeatherData().flatMap { data -> AnyPublisher<WeatherModelResponse, Never>  in
                guard let data = data else {
                    let response = WeatherModelResponse(model: nil, error: nil)
                    return Just(response).eraseToAnyPublisher()
                }
                return self.convertToDataModel(from: data)
            }.flatMap { response -> AnyPublisher<WeatherAppError?, Never> in
                self.weatherModel = response.model
                return Just(WeatherAppError.noInternetConnection).eraseToAnyPublisher()
            }.eraseToAnyPublisher()
        }
        
        var apiResponseData: Data? = nil
        let publisher = self.locationService.requestUserLocation().flatMap { response -> AnyPublisher<WeatherDataResponse, Never> in
            guard let coordinates = response.coordinates, response.error == nil else {
                let response = WeatherDataResponse(data: nil, error: .locationNotFound)
                return Just(response).eraseToAnyPublisher()
            }
            return self.requestWeatherData(from: coordinates).eraseToAnyPublisher()
        }.flatMap { response -> AnyPublisher<WeatherModelResponse, Never> in
            guard response.error == nil, let data = response.data else {
                let response = WeatherModelResponse(model: nil, error: .apiServiceError)
                return Just(response).eraseToAnyPublisher()
            }
            apiResponseData = data
            return self.convertToDataModel(from: data)
        }.flatMap { modelResponse -> AnyPublisher<WeatherModelResponse, Never> in
            guard modelResponse.error == nil, let model = modelResponse.model else {
                let response = WeatherModelResponse(model: nil, error: .apiServiceError)
                return Just(response).eraseToAnyPublisher()
            }
            return self.checkResponseModel(weatherModel: model)
        }.flatMap { modelResponse -> AnyPublisher<WeatherDataResponse, Never>  in
            guard modelResponse.error == nil, let model = modelResponse.model, let data = apiResponseData else {
                let response = WeatherDataResponse(data: nil, error: .apiServiceError)
                return Just(response).eraseToAnyPublisher()
            }
            self.weatherModel = model
            return self.fileService.writeWeatherData(json: data)
        }.flatMap { response -> AnyPublisher<WeatherAppError?, Never> in
            guard let _ = response.data else {
                return Just(WeatherAppError.apiServiceError).eraseToAnyPublisher()
            }
            return Just(response.error).eraseToAnyPublisher()
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
}

// MARK: - Request
extension DataLayer {
    private func convertToDataModel(from data: Data) -> AnyPublisher<WeatherModelResponse, Never> {
        return Future {promise in
            self.convertToDataModel(from: data) { response in
                promise(.success(response))
            }
        }.eraseToAnyPublisher()
    }
    
    fileprivate func convertToDataModel(from data: Data, callback: @escaping (WeatherModelResponse) -> ()) {
        DispatchQueue.global().async {
            do {
               let json = try JSONDecoder().decode(WeatherModel.self, from: data)
                let response = WeatherModelResponse(model: json, error: nil)
                callback(response)
            } catch let error {
                let response = WeatherModelResponse(model: nil, error: WeatherAppError.apiServiceError)
                callback(response)
            }
        }
    }
    
    private func checkResponseModel(weatherModel: WeatherModel) -> AnyPublisher<WeatherModelResponse, Never> {
        return Future {promise in
            DispatchQueue.global().async {
                self.checkResponseModel(weatherModel: weatherModel) { response in
                    promise(.success(response))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    fileprivate func checkResponseModel(weatherModel: WeatherModel, callback: @escaping (WeatherModelResponse) -> ()) {
        guard let _ = weatherModel.city, let listArr = weatherModel.list, listArr.count > 0 else {
            let response =  WeatherModelResponse(model: nil, error: .fileProcessingError)
            callback(response)
            return
        }
        
        guard listArr.first { listItem -> Bool in
            guard let _ = listItem.dt, let _ = listItem.main else { return true }
            return false
        } == nil else {
            let response = WeatherModelResponse(model: nil, error: .fileProcessingError)
            callback(response)
            return
        }
        callback(WeatherModelResponse(model: weatherModel, error: nil))
    }
    
    private func requestWeatherData(from coordinates: CLLocationCoordinate2D) -> AnyPublisher<WeatherDataResponse, Never> {
        return apiService.requestRx(service: .cityLocation(coordinates)).flatMap { response -> AnyPublisher<WeatherDataResponse, Never> in
            if let error = response.error {
                let response = WeatherDataResponse(data: nil, error: .apiServiceError)
                return Just(response).eraseToAnyPublisher()
            }
            guard let data = response.data else {
                let response = WeatherDataResponse(data: nil, error: .apiServiceError)
                return Just(response).eraseToAnyPublisher()
            }
            let response = WeatherDataResponse(data: data, error: nil)
            return Just(response).eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }

}

// MARK: - Mock
class DataLayerMock: DataLayer {
    
    override init(network: Network = Network.shared, weatherModel : WeatherModel? = nil) {
        super.init(network: network,weatherModel:  weatherModel)
    }
    
    
    func convertToDataModelMock(from data: Data, callback: @escaping (WeatherModelResponse) -> ()) {
        super.convertToDataModel(from: data, callback: callback)
    }
    
    func checkResponseModelMock(weatherModel: WeatherModel, callback: @escaping (WeatherModelResponse) -> ()) {
        super.checkResponseModel(weatherModel: weatherModel, callback: callback)
    }
    
    func listItemsMock(from selectedDate: Date) -> [List]{
        super.listItems(from: selectedDate)
    }
    
    func listItemMock(from selectedTime: Date) -> List? {
        super.listItem(from: selectedTime)
    }
    
    func dailyWeatherListItemsMock() -> [List] {
        super.dailyWeatherListItems()
    }
    
    
}
