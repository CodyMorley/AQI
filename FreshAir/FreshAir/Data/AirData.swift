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
