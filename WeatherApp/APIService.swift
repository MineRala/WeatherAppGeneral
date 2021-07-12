//
//  APIService.swift
//  WeatherApp
//
//  Created by Mine Rala on 1.07.2021.
//

import Foundation
import Combine

enum ForecastService {
    case cityLocation(Double,Double)
    
    var requestURL: String {
        switch self {
        case .cityLocation(let lat, let lon):
            return "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=bbcf57969e78d1300a815765b7d587f0&units=metric"
        }
    }
}

struct APIServiceResponse {
    let data: Data?
    let error: WeatherAppError?
}

class APIService {

    public func requestRx(service: ForecastService) -> AnyPublisher<APIServiceResponse, Never> {
        return Future { promise in
            self.request(service: service) { (data, error) in
                let response = APIServiceResponse(data: data, error: error)
                promise(.success(response))
            }
        }.eraseToAnyPublisher()
    }
    
    private func request(service: ForecastService, callBack: @escaping (Data?, WeatherAppError?) -> ()) {
        guard Network.shared.networkStatus.value == .online else {
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



