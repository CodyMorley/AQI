//
//  IAQI.swift
//  FreshAir
//
//  Created by Cody Morley on 5/14/24.
//

import Foundation


struct IAQI: Codable {
    struct DataPoint: Codable {
        let v: Double
    }
    
    let co: DataPoint?
    let h: DataPoint?
    let no2: DataPoint?
    let o3: DataPoint?
    let p: DataPoint?
    let pm10: DataPoint?
    let pm25: DataPoint?
    let so2: DataPoint?
    let t: DataPoint?
    let w: DataPoint?
    let wg: DataPoint?
}


extension IAQI {
    static let mockIAQI = IAQI(co: IAQI.DataPoint(v: 2.3),
                               h: IAQI.DataPoint(v: 64.7),
                               no2: IAQI.DataPoint(v: 6.3),
                               o3: IAQI.DataPoint(v: 40.8),
                               p: IAQI.DataPoint(v: 1031.9),
                               pm10: IAQI.DataPoint(v: 21),
                               pm25: IAQI.DataPoint(v: 44),
                               so2: IAQI.DataPoint(v: 0.2),
                               t: IAQI.DataPoint(v: 19.4),
                               w: IAQI.DataPoint(v: 0.1),
                               wg: IAQI.DataPoint(v: 0.7))
}
