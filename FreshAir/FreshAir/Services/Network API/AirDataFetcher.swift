//
//  AirDataFetcher.swift
//  FreshAir
//
//  Created by Cody Morley on 5/14/24.
//

import CoreLocation
import Foundation


struct AirDataFetcher {
    enum DataFetcherError: Error {
        case badData
        case badURL
        case noData
        
        var localizedDescription: String {
            switch self {
            case .badData: "Could not find data in response hash table at key 'data'"
            case .badURL: "Could not construct URL"
            case .noData: "No data returned from host"
            }
        }
    }
    
    func fetchAirData(location: CLLocation) async throws -> AirData {
        guard let url = try? getURL(coords: location.coordinate) else {
            throw DataFetcherError.badURL
        }
        print(url.absoluteString)
        
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            let error = DataFetcherError.noData
            NSLog(error.localizedDescription)
            throw error
        }
        
        do {
            let result = try JSONDecoder().decode(NetworkResult.self, from: data)
            if let airData = result.data {
                return airData
            } else {
                throw DataFetcherError.badData
            }
        } catch {
            throw error
        }
    }
    
    private func getURL(coords: CLLocationCoordinate2D) throws -> URL {
        let latLonString = "\(String(coords.latitude));\(String(coords.longitude))/"
        let key = "b8b4e0621b1d8be4adb4427bc8ed645e342e74ea"
        let path = "/feed/geo:"
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.waqi.info"
        components.path = path.appending(latLonString)
        components.queryItems = [URLQueryItem(name: "token", value: key)]
        
        guard let url = components.url else {
            let error = DataFetcherError.badURL
            NSLog(error.localizedDescription)
            throw error
        }
        
        return url
    }
}
