//
//  WeatherDataResponseModel.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 15.07.2021.
//

import Foundation

struct WeatherDataResponse {
    let data: Data?
    let error: WeatherAppError?
}

struct WeatherModelResponse {
    let model: WeatherModel?
    let error: WeatherAppError?
}
