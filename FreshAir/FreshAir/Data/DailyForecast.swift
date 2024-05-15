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
