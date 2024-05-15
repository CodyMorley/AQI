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
