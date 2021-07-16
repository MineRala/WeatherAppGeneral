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
    private var jsonPath: String = ""
    
    init(with jsonFilePath: String = "WeatherData.json") {
        self.jsonPath = jsonFilePath
    }
}

// MARK: - Public
extension FileService {

    func writeWeatherData(json: Data) -> AnyPublisher<WeatherDataResponse, Never> {
        guard let path = self.filePath() else {
            let response = WeatherDataResponse(data: nil, error: WeatherAppError.fileProcessingError)
            return Just(response).eraseToAnyPublisher()
        }
        return Future { promise in
            self.writeData(data: json, to: path) { error in
                if let err = error {
                    let response = WeatherDataResponse(data: nil, error: .fileProcessingError)
                    promise(.success(response))
                    return
                }
                let response = WeatherDataResponse(data: json, error: nil)
                promise(.success(response))
            }
        }.eraseToAnyPublisher()
    }
    
    func readWeatherData() -> AnyPublisher<Data?, Never> {
        guard self.isWeatherDataFileExists(), let path = self.filePath() else { return Just(nil).eraseToAnyPublisher() }
        return Future { promise in
            self.readData(from: path) { (data, error) in
                promise(.success(data))
            }
        }.eraseToAnyPublisher()
    }
    
}

// MARK: - Data write / read
extension FileService {
    fileprivate func writeData(data: Data, to path: URL, completion : @escaping (Error?)->()) {
        DispatchQueue.global().async {
            do {
                try data.write(to: path)
                completion(nil)
            } catch let err {
               completion(err)
            }
        }
    }
    
    fileprivate func readData(from path: URL, completion: @escaping (Data?, Error?) -> () ) {
        DispatchQueue.global().async {
            do {
                let jsonData = try Data(contentsOf: path)
                completion(jsonData, nil)
            } catch let err {
                completion(nil, err)
            }
        }
    }
    
}


// MARK: - Helpers
extension FileService {
    fileprivate func filePath() -> URL? {
        guard let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentsDir.appendingPathComponent(self.jsonPath)
    }
    
    fileprivate func isWeatherDataFileExists() -> Bool {
        guard let path = self.filePath() else { return false }
        guard let isReachable = try? path.checkResourceIsReachable() else { return false }
        return isReachable
    }
}

// MARK: - Mock
class FileServiceMock: FileService {
    static let jsonFilePath: String = "WeatherDataMock.json"
    
    override init(with jsonFilePath: String = FileServiceMock.jsonFilePath) {
        super.init(with: jsonFilePath)
    }
    
    public func filePathMock() -> URL? {
        return super.filePath()
    }
    
    public func writeDataMock(data: Data, to path: URL, completion : @escaping (Error?)->()) {
        super.writeData(data: data, to: path, completion: completion)
    }
    
    public func readDataMock(from path: URL, completion: @escaping (Data?, Error?) -> () ) {
        super.readData(from: path, completion: completion)
    }
    
    public func isWeatherDataFileExistsMock() -> Bool {
        return super.isWeatherDataFileExists()
    }
}
