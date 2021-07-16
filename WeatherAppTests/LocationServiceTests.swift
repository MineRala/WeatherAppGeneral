//
//  LocationServiceTests.swift
//  WeatherAppTests
//
//  Created by Aybek Can Kaya on 16.07.2021.
//

import XCTest
@testable import WeatherApp

class LocationServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_1_FakeLocationRequest() {
        let locationService = LocationServiceMock()
        let expectationA = expectation(description: "ExA")
        locationService.requestFakeLocationMock(callback: {response in
            XCTAssert(response.error == nil, "error should benil but error is : \(response.error)")
            XCTAssert(response.coordinates != nil, "Coordinates should not be nil")
            XCTAssert(response.coordinates!.latitude == C.App.fakeLocationCity.coordinates.latitude && response.coordinates!.longitude == C.App.fakeLocationCity.coordinates.longitude , "Coordinates are not matching")
            
            expectationA.fulfill()
           
        })
        
        wait(for: [expectationA], timeout: 15, enforceOrder: true)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
