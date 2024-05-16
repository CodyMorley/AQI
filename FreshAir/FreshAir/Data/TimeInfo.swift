//
//  TimeInfo.swift
//  FreshAir
//
//  Created by Cody Morley on 5/14/24.
//

import Foundation

struct TimeInfo: Codable {
    let s: String
    let tz: String
    let v: Int
    let iso: String
}

extension TimeInfo {
    static let mockTimeInfo = TimeInfo(s: "2024-05-14 16:00:00",
                                       tz: "-07:00", v: 1715702400,
                                       iso: "2024-05-14T16:00:00-07:00")
}
