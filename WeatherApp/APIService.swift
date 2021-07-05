//
//  APIService.swift
//  WeatherApp
//
//  Created by Mine Rala on 1.07.2021.
//

import Foundation

enum ForecastService {
    case cityLocation(Double,Double)
    
    var requestURL: String {
        switch self {
        case .cityLocation(let lat, let lon):
            // 38.313002, 26.383306

            return "https://api.openweathermap.org/data/2.5/forecast?lat=38.3130&lon=26.3833&appid=bbcf57969e78d1300a815765b7d587f0&units=metric"
            return "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=bbcf57969e78d1300a815765b7d587f0&units=metric"
        }
    }
}

class APIService {
    var city = ""

    func request(service: ForecastService, callBack: @escaping (Data?, Error?) -> ()) {
        
        let urlString = service.requestURL
        let url = URL(string: urlString)
        
        let request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10)
        
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else {
                callBack(nil, nil)
                return
            }
            
            if let error = error {
                callBack(nil, error)
                return
            }
            
            guard let response = response, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                callBack(nil, nil)
                return
            }
            
            callBack(data,nil)

        }
        dataTask.resume()
    }
}



