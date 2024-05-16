//
//  AirData.swift
//  FreshAir
//
//  Created by Cody Morley on 5/14/24.
//

import Foundation
struct AirData: Codable {
    let aqi: Int
    let idx: Int
    let attributions: [Attribution]
    let city: City
    let dominentpol: String
    let iaqi: IAQI
    let time: TimeInfo
    let forecast: Forecast
}

extension AirData {
    static let mockAirData = AirData(aqi: 44,
                                     idx: 243,
                                     attributions: Attribution.mockAttributions,
                                     city: City.mockCity,
                                     dominentpol: "pm25",
                                     iaqi: IAQI.mockIAQI,
                                     time: TimeInfo.mockTimeInfo,
                                     forecast: Forecast.mockForecast)
    
}
