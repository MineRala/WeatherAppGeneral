//
//  APIServiceTests.swift
//  WeatherAppTests
//
//  Created by Aybek Can Kaya on 16.07.2021.
//

import XCTest
import CoreLocation

@testable import WeatherApp


class APIServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_1_UrlConstruction() {
        let weatherService = WeatherService.cityLocation(CLLocationCoordinate2D(latitude: 10, longitude: 10))
        let urlPath = weatherService.requestURL
        
        XCTAssert(urlPath.contains(weatherService.baseURL), "Base URL not found. Current URL: \(urlPath)")
        XCTAssert(urlPath.contains(weatherService.appID), "App id component not found. URL: \(urlPath)")
        XCTAssert(urlPath.contains("lat"), "Lati not found. Current URL: \(urlPath)")
        XCTAssert(urlPath.contains("lon"), "Longi not found. Current URL: \(urlPath)")
        XCTAssert(urlPath.contains("appid"), "App id not found. Current URL: \(urlPath)")
    }
    
    func test_2_URLRequestCorrect() {
        let expectationA = expectation(description: "URL_A")
        let networkMock = NetworkMock()
        networkMock.setNetworkStatusMock(.online)
        let service = APIServiceMock(network: networkMock)
        let weatherService = WeatherService.cityLocation(CLLocationCoordinate2D(latitude: 39.9334, longitude: 32.8597))
        service.requestMock(service: weatherService) { (data, error) in
            XCTAssert(data != nil, "Data should not be nil")
            XCTAssert(error == nil, "Error should be nil ")
            expectationA.fulfill()
        }
        
        wait(for: [expectationA], timeout: 10.0, enforceOrder: true)
    }
    
    func test_3_URLRequestWrongCoordinates() {
        let expectationA = expectation(description: "URL_A")
        let networkMock = NetworkMock()
        networkMock.setNetworkStatusMock(.online)
        let service = APIServiceMock(network: networkMock)
        let weatherService = WeatherService.cityLocation(CLLocationCoordinate2D(latitude: 1239.9334, longitude: 1232.8597))
        service.requestMock(service: weatherService) { (data, error) in
            XCTAssert(data == nil, "Data should not be nil")
            XCTAssert(error != nil, "Error should be nil ")
            expectationA.fulfill()
        }
        
        wait(for: [expectationA], timeout: 10.0, enforceOrder: true)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
