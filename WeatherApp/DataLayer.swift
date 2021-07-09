//
//  DataLayer.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 9.07.2021.
//

import Foundation
import Combine

class DataLayer {
    private let apiService = APIService()
    private let fileService = FileService()
   
    private(set) var shouldShowError = PassthroughSubject<WeatherAppError, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    func requestWeatherData(latitude: Double, longitude: Double) -> AnyPublisher<Data?, Never> {
        return apiService.requestRx(service: .cityLocation(latitude, longitude)).flatMap { response -> AnyPublisher<FileServiceResponse, Never> in
            if let error = response.error {
                self.shouldShowError.send(error)
            }
            guard let data = response.data else { return Just(FileServiceResponse(error: .apiServiceError, data: nil)).eraseToAnyPublisher() }
            return self.fileService.writeWeatherData(json: data)
        }.flatMap { _ -> AnyPublisher<Data?, Never> in
            return self.fileService.readWeatherData()
        }.eraseToAnyPublisher()
    }
}
