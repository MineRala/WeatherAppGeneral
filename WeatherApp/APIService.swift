//
//  APIService.swift
//  WeatherApp
//
//  Created by Mine Rala on 1.07.2021.
//

import Foundation
import Combine
import CoreLocation


// MARK: - WeatherService
enum WeatherService {
    case cityLocation(CLLocationCoordinate2D)
    
    var baseURL: String {
        return "https://api.openweathermap.org/data/2.5/forecast"
    }
    
    var units: String {
        return "metric"
    }
    
    var appID: String {
        return "bbcf57969e78d1300a815765b7d587f0"
    }
    
    var requestURL: String {
        switch self {
        case .cityLocation(let coordinates):
            return "\(baseURL)?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(appID)&units=\(units)"
        }
    }
}


class APIService {
    private var network: Network!
    
    init(network: Network = Network.shared) {
        self.network = network
    }
}

// MARK: - Public
extension APIService {
    public func requestRx(service: WeatherService) -> AnyPublisher<WeatherDataResponse, Never> {
        return Future { promise in
            self.request(service: service) { (data, error) in
                let response = WeatherDataResponse(data: data, error: error)
                promise(.success(response))
            }
        }.eraseToAnyPublisher()
    }
}

// MARK: - Request
extension APIService {
    fileprivate func request(service: WeatherService, callBack: @escaping (Data?, WeatherAppError?) -> ()) {
        guard network.networkStatus.value == .online else {
            callBack(nil, WeatherAppError.noInternetConnection)
            return
        }
        let urlString = service.requestURL
        let url = URL(string: urlString)
        let request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10)
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else {
                callBack(nil, WeatherAppError.apiServiceDeallocated)
                return
            }
            
            if let error = error {
                callBack(nil, WeatherAppError.apiServiceError)
                return
            }
            
            guard let response = response, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                callBack(nil, .apiServiceResponseCodeIsNotOK)
                return
            }
            callBack(data,nil)
        }
        dataTask.resume()
    }
}

// MARK: - Mock
class APIServiceMock: APIService {
    
    override init(network: Network = Network.shared) {
        super.init(network: network)
    }
    
    func requestMock(service: WeatherService, callBack: @escaping (Data?, WeatherAppError?) -> ()) {
        super.request(service: service, callBack: callBack)
    }
}
