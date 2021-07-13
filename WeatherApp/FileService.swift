//
//  FileService.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 9.07.2021.
//

import Foundation
import Combine

class FileService {    
}

struct FileServiceResponse {
    let error: WeatherAppError?
    let data: Data?
}

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
    
    func writeWeatherData(json: Data) -> AnyPublisher<FileServiceResponse, Never> {
        guard let path = self.filePath() else {
            return Just( FileServiceResponse(error: WeatherAppError.fileProcessingError, data: nil)).eraseToAnyPublisher()
        }
        return Future { promise in
            DispatchQueue.global().async {
                do {
                    try json.write(to: path)
                    promise(.success(FileServiceResponse(error: nil, data: nil)) )
                } catch let err {
                    promise(.success(FileServiceResponse(error: WeatherAppError.fileProcessingError, data: nil)))
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


