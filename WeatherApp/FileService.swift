//
//  FileService.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 9.07.2021.
//

import Foundation
import Combine

// MARK: - File Service Skeleton
class FileService {
    
}

// MARK: - Public
extension FileService {

    func writeWeatherData(json: Data) -> AnyPublisher<WeatherDataResponse, Never> {
        guard let path = self.filePath() else {
            let response = WeatherDataResponse(data: nil, error: WeatherAppError.fileProcessingError)
            return Just(response).eraseToAnyPublisher()
        }
        return Future { promise in
            DispatchQueue.global().async {
                do {
                    try json.write(to: path)
                    let response = WeatherDataResponse(data: json, error: nil)
                    promise(.success(response))
                } catch let err {
                    let response = WeatherDataResponse(data: nil, error: .fileProcessingError)
                    promise(.success(response))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func readWeatherData() -> AnyPublisher<Data?, Never> {
        guard self.isWeatherDataFileExists(), let path = self.filePath() else { return Just(nil).eraseToAnyPublisher() }
        return Future { promise in
            DispatchQueue.global().async {
                let jsonData = try? Data(contentsOf: path)
                promise(.success(jsonData))
            }
        }.eraseToAnyPublisher()
    }
    
}

// MARK: - Helpers
extension FileService {
    private func filePath() -> URL? {
        guard let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentsDir.appendingPathComponent("WeatherData.json")
    }
    
    private func isWeatherDataFileExists() -> Bool {
        guard let path = self.filePath() else { return false }
        guard let isReachable = try? path.checkResourceIsReachable() else { return false }
        return isReachable
    }
}
