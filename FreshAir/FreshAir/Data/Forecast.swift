//
//  Forecast.swift
//  FreshAir
//
//  Created by Cody Morley on 5/14/24.
//

import Foundation


struct Forecast: Codable {
    let daily: [DailyForecast]
}
