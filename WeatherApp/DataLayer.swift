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
    private let apiService = APIService()
    private let fileService = FileService()
    private let locationService = LocationService()

    private(set) var weatherModel: WeatherModel? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
}

// MARK: - Public
extension DataLayer {
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
            guard modelResponse.error != nil, let model = modelResponse.model else {
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
            DispatchQueue.global().async {
                do {
                   let json = try JSONDecoder().decode(WeatherModel.self, from: data)
                    let response = WeatherModelResponse(model: json, error: nil)
                    promise(.success(response))
                } catch let error {
                    let response = WeatherModelResponse(model: nil, error: WeatherAppError.apiServiceError)
                    promise(.success(response))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    private func checkResponseModel(weatherModel: WeatherModel) -> AnyPublisher<WeatherModelResponse, Never> {
        guard let _ = weatherModel.city, let listArr = weatherModel.list, listArr.count > 0 else {
            let response =  WeatherModelResponse(model: nil, error: .fileProcessingError)
            return Just(response).eraseToAnyPublisher()
        }
        
        guard listArr.first { listItem -> Bool in
            guard let _ = listItem.dt, let main = listItem.main else { return true }
            return false
        } == nil else {
            let response = WeatherModelResponse(model: nil, error: .fileProcessingError)
            return Just(response).eraseToAnyPublisher()
        }
        return Just(WeatherModelResponse(model: weatherModel, error: nil)).eraseToAnyPublisher()
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
