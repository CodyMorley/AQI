//
//  ViewConfigurationManager.swift
//  FreshAir
//
//  Created by Cody Morley on 5/16/24.
//

import UIKit

class ViewConfigurationManager {
    
    public func getConfiguration(forAQI aqi: Int) -> AQIViewConfiguration {
        return AQIViewConfiguration(aqi)
    }
}
