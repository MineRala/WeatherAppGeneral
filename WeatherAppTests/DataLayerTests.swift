//
//  DataLayerTests.swift
//  WeatherAppTests
//
//  Created by Aybek Can Kaya on 16.07.2021.
//

import XCTest
import Combine

@testable import WeatherApp

class DataLayerTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_2_ConvertDataToWeatherModel() {
        let layer = DataLayerMock()
        let url = Bundle(for: type(of: self)).url(forResource: "weatherFakeAnkara", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let expectationA = expectation(description: "Convert_A")
        layer.convertToDataModelMock(from: data) { response in
            XCTAssert(response.error == nil, "Error should be nil. but error is : \(response.error)")
            XCTAssert(response.model != nil, "Model should not be nil")
            expectationA.fulfill()
        }
        
        wait(for: [expectationA], timeout: 10, enforceOrder: true)
    }
    
    func test_1_ConvertCorruptedDataToWeatherModel() {
        let layer = DataLayerMock()
        let url = Bundle(for: type(of: self)).url(forResource: "weatherCorrupted", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let expectationA = expectation(description: "Convert_A")
        layer.convertToDataModelMock(from: data) { response in
            XCTAssert(response.model != nil, "Model should not be nil")
            XCTAssert(response.model!.list == nil, "List should be nil")
            XCTAssert(response.error == nil, "Error should be nil. but error is : \(response.error)")
            expectationA.fulfill()
        }
        
        wait(for: [expectationA], timeout: 10, enforceOrder: true)
    }
    
    func test_3_CheckCorrectWeatherModel() {
        let layer = DataLayerMock()
        let url = Bundle(for: type(of: self)).url(forResource: "weatherFakeAnkara", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let expectationA = expectation(description: "Convert_A")
        layer.convertToDataModelMock(from: data) { response in
            XCTAssert(response.error == nil, "Error should be nil. but error is : \(response.error)")
            XCTAssert(response.model != nil, "Model should not be nil")
            
            layer.checkResponseModelMock(weatherModel: response.model!) { responseCheck in
                XCTAssert(responseCheck.model != nil, "Model should Not Be Nil")
                XCTAssert(responseCheck.error == nil, "Error should be nil. but error is : \(responseCheck.error)")
                expectationA.fulfill()
            }
        }
        
        wait(for: [expectationA], timeout: 10, enforceOrder: true)
    }
    
    func test_4_CheckCorruptedWeatherModel() {
        let layer = DataLayerMock()
        let url = Bundle(for: type(of: self)).url(forResource: "weatherCorrupted", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let expectationA = expectation(description: "Convert_A")
        layer.convertToDataModelMock(from: data) { response in
            XCTAssert(response.model != nil, "Model should not be nil")
            XCTAssert(response.model!.list == nil, "List should be nil")
            XCTAssert(response.error == nil, "Error should be nil. but error is : \(response.error)")
            
            layer.checkResponseModelMock(weatherModel: response.model!) { responseCheck in
                XCTAssert(responseCheck.model == nil, "Model should Not Be Nil")
                XCTAssert(responseCheck.error != nil, "Error should be nil. but error is : \(responseCheck.error)")
                expectationA.fulfill()
            }
        }
        
        wait(for: [expectationA], timeout: 10, enforceOrder: true)
    }
    
    func test_5_Initialize() {
        let network = NetworkMock()
        network.setNetworkStatusMock(.online)
        let layer = DataLayerMock(network: network)
        let expectationA = expectation(description: "Convert_A")
        
        layer.initialize().sink { error in
            XCTAssert(error == nil, "Error should be nil but error is : \(error)")
            XCTAssert(layer.weatherModel != nil , "Weather Model should not be nil")
            expectationA.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectationA], timeout: 10, enforceOrder: true)
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
