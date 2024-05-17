//
//  NetworkResult.swift
//  FreshAir
//
//  Created by Cody Morley on 5/16/24.
//

import Foundation


struct NetworkResult: Codable {
    let status: String
    let data: AirData?
}
