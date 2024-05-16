//
//  MockAirQualityDataManager.swift
//  FreshAir
//
//  Created by Cody Morley on 5/15/24.
//

import Foundation

class MockAirQualityDataManager: AirQualityDataManaging {
    var data: AirData?
    
    init(data: AirData? = AirData.mockAirData) {
        self.data = data
    }
}
