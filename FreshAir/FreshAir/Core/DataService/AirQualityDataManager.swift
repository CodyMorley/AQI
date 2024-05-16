//
//  AirQualityDataManager.swift
//  FreshAir
//
//  Created by Cody Morley on 5/14/24.
//

import Foundation
import CoreLocation

protocol AirQualityDataManaging {
    var data: AirData? { get set }
}

class AirQualityDataManager: NSObject, AirQualityDataManaging {
    private let api = AirDataFetcher()
    private let locationManager = CLLocationManager()
    var data: AirData? = nil
    var location: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @MainActor
    func fetchAirData() async {
        guard let location else { return }
        do {
            data = try await api.fetchAirData(location: location)
        } catch {
            NSLog("\(error.localizedDescription)")
            NSLog("\(error)")
        }
    }
}

extension AirQualityDataManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        self.location = location
        
        Task { await fetchAirData() }
    }
}
