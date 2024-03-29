//
//  LocationService.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 15.07.2021.
//

import Foundation
import SwiftLocation
import CoreLocation
import Combine

// MARK: - WeatherServiceCity
enum WeatherServiceCity {
    case paris
    case moon
    
    var coordinates: CLLocationCoordinate2D {
        switch self {
            case .paris: return CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522)
            case .moon: return CLLocationCoordinate2D(latitude: 1200.323, longitude: -3409.938)
        }
    }
}

// MARK: - Location Service Response
struct LocationServiceResponse {
    let coordinates: CLLocationCoordinate2D?
    let error: WeatherAppError?
}

class LocationService {
    
}

extension LocationService {
    func requestUserLocation() -> AnyPublisher<LocationServiceResponse, Never> {
        switch C.App.locationRequestType {
            case .fakeLocation:
                return requestFakeLocation()
            case .realLocation:
                return requestUserLocation()
        }
    }
}

// MARK: - Requester
extension LocationService {
    private func requestFakeLocation() -> AnyPublisher<LocationServiceResponse, Never> {
        return Future {promise in
            self.requestFakeLocation { response in
                promise(.success(response))
            }
        }.eraseToAnyPublisher()
    }
    
    fileprivate func requestFakeLocation(callback: @escaping (LocationServiceResponse) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(LocationRequestType.fakeLocation.simulationWaitInterval)) {
            let response = LocationServiceResponse(coordinates: C.App.fakeLocationCity.coordinates, error: nil)
            callback(response)
        }
    }
    
    private func requestLocation() -> AnyPublisher<LocationServiceResponse, Never> {
        return Future { promise in
            SwiftLocation.gpsLocationWith {
                $0.subscription = .single
                $0.accuracy = .neighborhood
            }.then { result in // you can attach one or more subscriptions via `then`.
                switch result {
                case .success(let newData):
                    let response = LocationServiceResponse(coordinates: newData.coordinate, error: nil)
                    promise(.success(response))
                case .failure(let error):
                    let response = LocationServiceResponse(coordinates: nil, error: .locationNotFound)
                    promise(.success(response))
                }
            }
        }.eraseToAnyPublisher()
    }
}

// MARK: - Mock
class LocationServiceMock: LocationService {
    func requestFakeLocationMock(callback: @escaping (LocationServiceResponse) -> ()) {
        super.requestFakeLocation(callback: callback)
    }
}
