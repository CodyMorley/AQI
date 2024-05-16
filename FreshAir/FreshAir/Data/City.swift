//
//  City.swift
//  FreshAir
//
//  Created by Cody Morley on 5/14/24.
//

import Foundation

struct City: Codable {
    let geo: [Double]
    let name: String
    let url: String
    let location: String
}

extension City {
    static let mockCity = City(geo: [34.06653, -118.22676],
                               name: "Los Angeles-North Main Street",
                               url: "https://aqicn.org/city/losangeles/los-angeles-north-main-street",
                               location: "")
}
