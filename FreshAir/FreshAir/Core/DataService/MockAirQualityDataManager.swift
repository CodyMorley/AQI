//
//  MockAirQualityDataManager.swift
//  FreshAir
//
//  Created by Cody Morley on 5/15/24.
//

import Combine
import Foundation

class MockAirQualityDataManager: AirQualityDataManaging {
    var publisher = CurrentValueSubject<AirData?, Never>(AirData.mockAirData)
}
