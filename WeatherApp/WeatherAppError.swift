//
//  WeatherAppError.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 9.07.2021.
//

import Foundation

enum WeatherAppError {
    case apiServiceDeallocated
    case apiServiceError
    case apiServiceResponseCodeIsNotOK
    case noInternetConnection
    case locationNotFound
    case apiDataNotFound
    case fileProcessingError
    
    var title: String {
        switch self {
        case .apiServiceDeallocated, .apiServiceError, .apiServiceResponseCodeIsNotOK, .noInternetConnection, .fileProcessingError:
            return "Error"
        case .locationNotFound:
            return "Location not found."
        case .apiDataNotFound:
            return "Api error."
        }
    }
    
    var errorDescription: String {
        switch self {
        case .apiServiceDeallocated, .apiServiceError, .apiServiceResponseCodeIsNotOK :
            return "API does not responding to your request. Please try again later."
        case .noInternetConnection:
            return "No internet connection !"
        case .locationNotFound:
            return "We cannot yor location. Please , try again."
        case .apiDataNotFound:
            return "We cannot get any data from API."
        case .fileProcessingError:
            return "There was an error while processing weather data"
        }
    }
}
