//
//  AQIViewConfiguration.swift
//  FreshAir
//
//  Created by Cody Morley on 5/16/24.
//

import UIKit

struct AQIViewConfiguration {
    let aqi: String
    let color: UIColor
    let qualityDescription: String
    
    init(_ value: Int) {
        self.aqi = String(value)
        
        switch value {
        case 0...50:
            self.color = UIColor.green
        case 51...100:
            self.color = UIColor.yellow
        case 101...150:
            self.color = UIColor.orange
        case 151...200:
            self.color = UIColor.purple
        case 201...300:
            self.color = UIColor.red
        case 300...Int.max:
            self.color = UIColor.red
        default:
            self.color = UIColor.gray
        }
        
        switch value {
        case Int.min...50:
            qualityDescription = "High Air Quality"
        case 51...100:
            qualityDescription = "Moderate Air Quality"
        case 101...150:
            qualityDescription = "Air Quality Unhealthy for Sensitive Groups"
        case 151...200:
            qualityDescription = "Unhealthy Air Quality"
        case 201...300:
            qualityDescription = "Very Unhealthy Air Quality"
        case 300...Int.max:
            qualityDescription = "Air Quality Hazaradous. Seek Shelter Indoors."
        default:
            qualityDescription = "Unknown air quality"
        }
    }
}
