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
           // 40.198336, 29.035903
            return "https://api.openweathermap.org/data/2.5/forecast?lat=40.198336&lon=29.035903&appid=bbcf57969e78d1300a815765b7d587f0&units=metric"
            return "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=bbcf57969e78d1300a815765b7d587f0&units=metric"
        }
    }
}

enum APIServiceError: Error {
    case apiServiceDeallocated
    case apiServiceError
    case apiServiceResponseCodeIsNotOK
    case noInternetConnection
    
    var title: String {
        switch self {
        case .apiServiceDeallocated, .apiServiceError, .apiServiceResponseCodeIsNotOK, .noInternetConnection:
            return "Error"
        }
    }
    
    var errorDescription: String {
        switch self {
        case .apiServiceDeallocated, .apiServiceError, .apiServiceResponseCodeIsNotOK :
            return "API does not responding to your request. Please try again later."
        case .noInternetConnection:
            return "Your internet connection appears offline."
        }
    }
}

struct APIServiceResponse {
    let data: Data?
    let error: APIServiceError?
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
    
    private func request(service: ForecastService, callBack: @escaping (Data?, APIServiceError?) -> ()) {
        guard Network.shared.networkStatus.value == .online else {
            callBack(nil, APIServiceError.noInternetConnection)
            return
        }
        let urlString = service.requestURL
        let url = URL(string: urlString)
        let request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10)
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else {
                callBack(nil, APIServiceError.apiServiceDeallocated)
                return
            }
            
            if let error = error {
                callBack(nil, APIServiceError.apiServiceError)
                return
            }
            
            guard let response = response, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                callBack(nil, APIServiceError.apiServiceResponseCodeIsNotOK)
                return
            }
            
            callBack(data,nil)
        }
        dataTask.resume()
    }
}



