//
//  AirQualityDataManager.swift
//  FreshAir
//
//  Created by Cody Morley on 5/14/24.
//

import Combine
import CoreLocation
import Foundation


protocol AirQualityDataManaging {
    var publisher: CurrentValueSubject<AirData?, Never> { get }
}


class MockAirQualityDataManager: AirQualityDataManaging {
    var publisher = CurrentValueSubject<AirData?, Never>(nil)
    
    func publish() {
        publisher.send(AirData.mockAirData)
    }
}


class AirQualityDataManager: NSObject, AirQualityDataManaging {
    private let api: AirDataFetching
    private let locationManager = CLLocationManager()
    private(set) var data: AirData? = nil
    private(set) var location: CLLocation?
    var publisher = CurrentValueSubject<AirData?, Never>(nil)
    
    
    init(api: AirDataFetching = AirDataFetcher()) {
        self.api = api
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
            let recieved = try await api.fetchAirData(location: location)
            DispatchQueue.main.async {
                self.data = recieved
                self.publisher.send(recieved)
            }
        } catch {
            NSLog("\(error.localizedDescription)")
            NSLog("\(error)")
        }
    }
    
    func setLocationForTesting(location: CLLocation) {
        self.location = location
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
