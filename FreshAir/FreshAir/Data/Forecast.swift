//
//  Forecast.swift
//  FreshAir
//
//  Created by Cody Morley on 5/14/24.
//

import Foundation


struct Forecast: Codable {
    let daily: [String : [DailyForecast]]
}


extension Forecast {
    static let mockForecast = Forecast(daily: ["o3" : [DailyForecast(avg: 13, day: "2024-05-12", max: 54, min: 1),
                                                       DailyForecast(avg: 9, day: "2024-05-13", max: 41, min: 1),
                                                       DailyForecast(avg: 8, day: "2024-05-14", max: 46, min: 1),
                                                       DailyForecast(avg: 5, day: "2024-05-15", max: 30, min: 1),
                                                       DailyForecast(avg: 7, day: "2024-05-16", max: 51, min: 1),
                                                       DailyForecast(avg: 8, day: "2024-05-17", max: 49, min: 1),
                                                       DailyForecast(avg: 6, day: "2024-05-18", max: 35, min: 1),
                                                       DailyForecast(avg: 7, day: "2024-05-19", max: 34, min: 1)],
                                               "pm10" : [DailyForecast(avg: 43, day: "2024-05-12", max: 54, min: 27),
                                                         DailyForecast(avg: 37, day: "2024-05-14", max: 51, min: 20),
                                                         DailyForecast(avg: 33, day: "2024-05-15", max: 48, min: 18),
                                                         DailyForecast(avg: 37, day: "2024-05-16", max: 59, min: 23),
                                                         DailyForecast(avg: 44, day: "2024-05-17", max: 70, min: 23),
                                                         DailyForecast(avg: 23, day: "2024-05-18", max: 31, min: 11),
                                                         DailyForecast(avg: 33, day: "2024-05-19", max: 49, min: 14)],
                                               "pm25" : [DailyForecast(avg: 96, day: "2024-05-12", max: 130, min: 69),
                                                         DailyForecast(avg: 94, day: "2024-05-13", max: 123, min: 66),
                                                         DailyForecast(avg: 78, day: "2024-05-14", max: 114, min: 51),
                                                         DailyForecast(avg: 66, day: "2024-05-15", max: 91, min: 41),
                                                         DailyForecast(avg: 79, day: "2024-05-16", max: 151, min: 52),
                                                         DailyForecast(avg: 95, day: "2024-05-17", max: 158, min: 53),
                                                         DailyForecast(avg: 51, day: "2024-05-18", max: 71, min: 26),
                                                         DailyForecast(avg: 67, day: "2024-05-19", max: 102, min: 25)]])
}
