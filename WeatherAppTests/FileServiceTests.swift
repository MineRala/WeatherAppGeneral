//
//  FileServiceTests.swift
//  WeatherAppTests
//
//  Created by Aybek Can Kaya on 16.07.2021.
//

import XCTest
@testable import WeatherApp

class FileServiceTests: XCTestCase {
    private let fileService = FileServiceMock()
    
    override func setUpWithError() throws {
        self.removeFileAtPath(fileService.filePathMock()!)
    }

    override func tearDownWithError() throws {
        self.removeFileAtPath(fileService.filePathMock()!)
    }

    func test_1_FilePathConstruction() {
        var url: URL?
        
        url = fileService.filePathMock()
        XCTAssert(url != nil, "URL should not be nil. Current URL: \(url)")
        XCTAssert(url?.absoluteString.components(separatedBy: "/").last == FileServiceMock.jsonFilePath, "Filepath is not appropriate. Current file : \(url?.absoluteString.components(separatedBy: "/").last)")
    }
    
    func test_2_DataWrite() {
        let url = fileService.filePathMock()!
        
        let expectationA = expectation(description: "FileWriteA")
        
        var dct: [String: Any] = ["M1": "Mine", "M2": "Mustafa"]
        var jsonData = try? JSONSerialization.data(withJSONObject: dct, options: .prettyPrinted)
        XCTAssert(jsonData != nil, "Json Converting Error")
        
        fileService.writeDataMock(data: jsonData!, to: url, completion : { error in
            DispatchQueue.main.async {
                
                XCTAssert(error == nil, "Error should be nil , but current error : \(error)")
                XCTAssert(self.isFileExistsAtPath(url) == true, "File should be exist at url: \(url). But there is no file appears.")
                XCTAssert(self.fileService.isWeatherDataFileExistsMock() == true, "Weather json file Not Found.")
            
                dct = ["M1": "Mustafa", "M2": "Mine"]
                jsonData = try? JSONSerialization.data(withJSONObject: dct, options: .prettyPrinted)
                XCTAssert(jsonData != nil, "Json Converting Error")
                
                self.fileService.writeDataMock(data: jsonData!, to: url, completion : { error in
                    DispatchQueue.main.async {
                        XCTAssert(error == nil, "Error should be nil , but current error : \(error)")
                        XCTAssert(self.isFileExistsAtPath(url) == true, "File should be exist at url: \(url). But there is no file appears.")
                        XCTAssert(self.fileService.isWeatherDataFileExistsMock() == true, "Weather json file Not Found.")
                        self.removeFileAtPath(url)
                        XCTAssert(self.fileService.isWeatherDataFileExistsMock() == false, "Weather json file is FOUND !!!")
                        expectationA.fulfill()
                    }
                })
                
            }
        })
    
        wait(for: [expectationA], timeout: 10.0, enforceOrder: true)
    }
    
    func test_3_FileReading() {
        let url = fileService.filePathMock()!
        let expectationA = expectation(description: "FileReadA")
        
        fileService.readDataMock(from: url, completion: { data, error in
            XCTAssert(data == nil, "Data should be nil")
            XCTAssert(error != nil , "Error should not be nil")
            expectationA.fulfill()
        })
        
        var dct: [String: Any] = ["M1": "Mine", "M2": "Mustafa"]
        var jsonData = try? JSONSerialization.data(withJSONObject: dct, options: .prettyPrinted)
        XCTAssert(jsonData != nil, "Json Converting Error")
        let expectationB = expectation(description: "FileReadB")
        
        fileService.writeDataMock(data: jsonData!, to: url, completion : { error in
            self.fileService.readDataMock(from: url) { (data, error) in
                DispatchQueue.main.async {
                    XCTAssert(data != nil , "Data should not be nil")
                    XCTAssert(error == nil, "Error should be nil. but current error is : \(error)")
                    let json = try? JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    XCTAssert(json != nil , "Json is null")
                    let dct = json as? [String: Any]
                    XCTAssert(dct != nil, "Dictionary conversion error")
                    let val = dct!["M1"] as? String
                    XCTAssert( val == "Mine", "Mine is not found. Current Value : \(dct) ")
                    expectationB.fulfill()
                }
            }
        })
    
        wait(for: [expectationA, expectationB], timeout: 3.0, enforceOrder: true)
    }
    
    
    private func isFileExistsAtPath(_ path: URL) -> Bool {
        let isExists = FileManager.default.fileExists(atPath: path.path)
        return isExists
    }
    
    private func removeFileAtPath(_ path: URL) {
        try? FileManager.default.removeItem(at: path)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
