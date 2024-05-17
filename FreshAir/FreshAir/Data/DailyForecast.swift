//
//  DailyForecast.swift
//  FreshAir
//
//  Created by Cody Morley on 5/14/24.
//

import Foundation


struct DailyForecast: Codable {
    let avg: Int
    let day: String
    let max: Int
    let min: Int
}


extension DailyForecast {
    static let mockDailyForecast = DailyForecast(avg: 13, day: "2024-05-12", max: 54, min: 1)
}
