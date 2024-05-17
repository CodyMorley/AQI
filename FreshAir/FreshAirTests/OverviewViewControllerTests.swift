//
//  OverviewViewControllerTests.swift
//  FreshAirTests
//
//  Created by Cody Morley on 5/16/24.
//

import XCTest

import XCTest
import Combine
@testable import FreshAir

final class OverviewViewControllerTests: XCTestCase {
    var viewController: OverviewViewController!
    var mockDataManager: MockAirQualityDataManager!
    
    override func setUp() {
        super.setUp()
        mockDataManager = MockAirQualityDataManager()
        viewController = OverviewViewController(dataManager: mockDataManager)
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewController = nil
        mockDataManager = nil
        super.tearDown()
    }
    
    func testViewDidLoad_initialState() {
        XCTAssertNotNil(viewController.view)
        XCTAssertNil(viewController.header)
        XCTAssertNil(viewController.today)
        XCTAssertNil(viewController.yesterday)
        XCTAssertNil(viewController.tomorrow)
        XCTAssertNotNil(viewController.activityIndicator)
    }
    
    func testConfigureSubviewState_noData() {
        viewController.configureSubviewState(withData: nil)
        
        XCTAssertNotNil(viewController.activityIndicator)
        XCTAssertNil(viewController.header, "Header should be nil")
        XCTAssertNil(viewController.today, "Today view should be nil")
        XCTAssertNil(viewController.yesterday, "Yesterday view should be nil")
        XCTAssertNil(viewController.tomorrow, "Tomorrow view should be nil")
    }
    
    func testConfigureSubviewState_withData() {
        let testData = AirData.mockAirData
        viewController.configureSubviewState(withData: testData)
        
        XCTAssertNil(viewController.activityIndicator, "Activity indicator should be removed")
        XCTAssertNotNil(viewController.header, "Header should be configured")
        XCTAssertNotNil(viewController.today, "Today view should be configured")
        XCTAssertNotNil(viewController.yesterday, "Yesterday view should be configured")
        XCTAssertNotNil(viewController.tomorrow, "Tomorrow view should be configured")
    }
    
    func testUpdateViews_withData() {
        let testData = AirData.mockAirData
        viewController.updateViews(testData)
        
        XCTAssertNotNil(viewController.header, "Header should be updated")
        XCTAssertNotNil(viewController.today, "Today view should be updated")
        XCTAssertNotNil(viewController.yesterday, "Yesterday view should be updated")
        XCTAssertNotNil(viewController.tomorrow, "Tomorrow view should be updated")
        XCTAssertNil(viewController.activityIndicator, "Activity indicator should be removed")
    }
}
