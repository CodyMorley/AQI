//
//  AirQualityDataManagerTests.swift
//  FreshAirTests
//
//  Created by Cody Morley on 5/16/24.
//

import XCTest
import CoreLocation
@testable import FreshAir

final class AirQualityDataManagerTests: XCTestCase {
    var dataManager: AirQualityDataManager!
    var mockFetcher: MockAirDataFetcher!
    
    override func setUp() {
        super.setUp()
        mockFetcher = MockAirDataFetcher()
        dataManager = AirQualityDataManager(api: mockFetcher)
    }
    
    override func tearDown() {
        dataManager = nil
        mockFetcher = nil
        super.tearDown()
    }
    
    func testFetchAirDataSuccess() async {
        let expectation = XCTestExpectation(description: "Publisher should receive data")
        var receivedData: AirData? = nil
        let cancellable = dataManager.publisher.sink { data in
            receivedData = data
            if data != nil {
                expectation.fulfill()
            }
        }
        
        dataManager.setLocationForTesting(location: CLLocation(latitude: 37.7749, longitude: -122.4194))
        await dataManager.fetchAirData()
        
        await fulfillment(of: [expectation], timeout: 2.0)
        XCTAssertNotNil(receivedData)
        XCTAssertEqual(receivedData?.time.v, AirData.mockAirData.time.v)
        cancellable.cancel()
    }
    
    func testFetchAirDataFailure() async {
        let expectation = XCTestExpectation(description: "Publisher should not receive data")
        mockFetcher.shouldThrowError = true
        var receivedData: AirData? = nil
        let cancellable = dataManager.publisher.sink { data in
            receivedData = data
        }
        
        dataManager.setLocationForTesting(location: CLLocation(latitude: 37.7749, longitude: -122.4194))
        await dataManager.fetchAirData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNil(receivedData)
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)
        cancellable.cancel()
    }
    
    func testPublisherInitiallyNil() {
        let initialData = dataManager.publisher.value
        XCTAssertNil(initialData)
    }
}
