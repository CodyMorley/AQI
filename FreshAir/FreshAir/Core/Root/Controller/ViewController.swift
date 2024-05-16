//
//  ViewController.swift
//  FreshAir
//
//  Created by Cody Morley on 5/14/24.
//

// MARK: CREATE SUBVIEWS
// MARK: STACK SUBVIEWS
// MARK: CREATE PROGRESSVIEW ALT FOR ASYNC WAIT TIME
// MARK: USE COMBINE TO UPDATE VIEWCONTROLLER WHEN DATA MANAGER HAS DATA

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    var dataManager: AirQualityDataManaging
    
    private(set) var aqiLabel = UILabel()
    private(set) var aqiDescriptionLabel = UILabel()
    private(set) var cityLabel = UILabel()
    private(set) var latLabel = UILabel()
    private(set) var longLabel = UILabel()
    private(set) var tomorrowDescriptionLabel = UILabel()
    private(set) var tomorrowHeaderLabel = UILabel()
    private(set) var tomorrowValueLabel = UILabel()
    private(set) var yesterdayDescriptionLabel = UILabel()
    private(set) var yesterdayHeaderLabel = UILabel()
    private(set) var yesterdayValueLabel = UILabel()
    
    
    
    init(dataManager: AirQualityDataManaging = AirQualityDataManager()) {
        self.dataManager = dataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    private func configureSubviews() {
        configureBackground()
        configureCityLabel()
        configureLatLabel()
        configureLongLabel()
        configureAQILabel()
        configureAQIDescriptionLabel()
        configureYesterdayHeaderLabel()
        configureTomorrowHeaderLabel()
        configureYesterdayValueLabel()
        configureTomorrowValueLabel()
        configureYesterdayDescriptionLabel()
        configureTomorrowDescriptionLabel()
    }
    
    private func configureAQILabel() {
        aqiLabel.textAlignment = .center
        aqiLabel.text = "55"
        aqiLabel.textColor = getAssociatedColor(for: 55)
        aqiLabel.font = UIFont.monospacedSystemFont(ofSize: 84, weight: UIFont.Weight.bold)
        aqiLabel.backgroundColor = .clear
        aqiLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aqiLabel)
        aqiLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        aqiLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 234).isActive = true
    }
    
    private func configureAQIDescriptionLabel() {
        aqiDescriptionLabel.textColor = getAssociatedColor(for: 55)
        aqiDescriptionLabel.font = UIFont.monospacedSystemFont(ofSize: 14, weight: UIFont.Weight.bold)
        aqiDescriptionLabel.text = getTextDescription(for: 55)
        aqiDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aqiDescriptionLabel)
        aqiDescriptionLabel.centerXAnchor.constraint(equalTo: aqiLabel.centerXAnchor).isActive = true
        aqiDescriptionLabel.topAnchor.constraint(equalTo: aqiLabel.bottomAnchor, constant: -12).isActive = true
    }
    
    private func configureBackground() {
        let background = UIImageView(image: UIImage(named: "blue_skies"))
        view.addSubview(background)
        background.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        background.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        background.layer.zPosition = -2
    }
    
    private func configureCityLabel() {
        cityLabel.text = "Los Angeles, CA"
        cityLabel.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.light)
        cityLabel.textAlignment = .center
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cityLabel)
        cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cityLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 96).isActive = true
    }
    
    private func configureLatLabel() {
        latLabel.text = "Latitude: \(AirData.mockAirData.city.geo[0])"
        latLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        latLabel.textAlignment = .center
        latLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(latLabel)
        latLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 4).isActive = true
        latLabel.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor).isActive = true
    }
    
    private func configureLongLabel() {
        longLabel.text = "Longitude: \(AirData.mockAirData.city.geo[1])"
        longLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        longLabel.textAlignment = .center
        longLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(longLabel)
        longLabel.topAnchor.constraint(equalTo: latLabel.bottomAnchor, constant: 4).isActive = true
        longLabel.leadingAnchor.constraint(equalTo: latLabel.leadingAnchor).isActive = true
    }
    
    private func configureTomorrowDescriptionLabel() {
        tomorrowDescriptionLabel.textColor = getAssociatedColor(for: 21)
        tomorrowDescriptionLabel.font = UIFont.monospacedSystemFont(ofSize: 14, weight: UIFont.Weight.bold)
        tomorrowDescriptionLabel.text = getTextDescription(for: 21)
        tomorrowDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tomorrowDescriptionLabel)
        tomorrowDescriptionLabel.centerXAnchor.constraint(equalTo: tomorrowValueLabel.centerXAnchor).isActive = true
        tomorrowDescriptionLabel.topAnchor.constraint(equalTo: tomorrowValueLabel.bottomAnchor, constant: -12).isActive = true
    }
    
    private func configureTomorrowHeaderLabel() {
        tomorrowHeaderLabel.text = "Tomorrow's Forecast:"
        tomorrowHeaderLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        tomorrowHeaderLabel.textAlignment = .center
        tomorrowHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tomorrowHeaderLabel)
        tomorrowHeaderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tomorrowHeaderLabel.topAnchor.constraint(equalTo: yesterdayHeaderLabel.bottomAnchor, constant: 136).isActive = true
    }
    
    private func configureTomorrowValueLabel() {
        tomorrowValueLabel.textAlignment = .center
        tomorrowValueLabel.text = "21"
        tomorrowValueLabel.textColor = getAssociatedColor(for: 21)
        tomorrowValueLabel.font = UIFont.monospacedSystemFont(ofSize: 84, weight: UIFont.Weight.bold)
        tomorrowValueLabel.backgroundColor = .clear
        tomorrowValueLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tomorrowValueLabel)
        tomorrowValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tomorrowValueLabel.topAnchor.constraint(equalTo: tomorrowHeaderLabel.bottomAnchor, constant: 4).isActive = true
    }
    
    private func configureYesterdayDescriptionLabel() {
        yesterdayDescriptionLabel.textColor = getAssociatedColor(for: 49)
        yesterdayDescriptionLabel.font = UIFont.monospacedSystemFont(ofSize: 14, weight: UIFont.Weight.bold)
        yesterdayDescriptionLabel.text = getTextDescription(for: 49)
        yesterdayDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(yesterdayDescriptionLabel)
        yesterdayDescriptionLabel.centerXAnchor.constraint(equalTo: yesterdayValueLabel.centerXAnchor).isActive = true
        yesterdayDescriptionLabel.topAnchor.constraint(equalTo: yesterdayValueLabel.bottomAnchor, constant: -12).isActive = true
    }
    
    private func configureYesterdayHeaderLabel() {
        yesterdayHeaderLabel.text = "Compare to Yesterday:"
        yesterdayHeaderLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        yesterdayHeaderLabel.textAlignment = .center
        yesterdayHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(yesterdayHeaderLabel)
        yesterdayHeaderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        yesterdayHeaderLabel.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func configureYesterdayValueLabel() {
        yesterdayValueLabel.textAlignment = .center
        yesterdayValueLabel.text = "49"
        yesterdayValueLabel.textColor = .green
        yesterdayValueLabel.font = UIFont.monospacedSystemFont(ofSize: 84, weight: UIFont.Weight.bold)
        yesterdayValueLabel.backgroundColor = .clear
        yesterdayValueLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(yesterdayValueLabel)
        yesterdayValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        yesterdayValueLabel.topAnchor.constraint(equalTo: yesterdayHeaderLabel.bottomAnchor, constant: 4).isActive = true
    }
    
    
    private func getTextDescription(for aqi: Int) -> String {
        switch aqi {
        case Int.min...50:
            "High Air Quality"
        case 51...100:
            "Moderate Air Quality"
        case 101...150:
            "Air Quality Unhealthy for Sensitive Groups"
        case 151...200:
            "Unhealthy Air Quality"
        case 201...300:
            "Very Unhealthy Air Quality"
        case 300...Int.max:
            "Air Quality Hazaradous. Seek Shelter Indoors."
        default:
            "Unknown air quality"
        }
    }
    
    private func getAssociatedColor(for aqi: Int) -> UIColor {
        switch aqi {
        case Int.min...50:
            UIColor.green
        case 51...100:
            UIColor.yellow
        case 101...150:
            UIColor.orange
        case 151...200:
            UIColor.purple
        case 201...300:
            UIColor.red
        case 300...Int.max:
            UIColor.red
        default:
            UIColor.gray
        }
    }
}


#Preview {
    ViewController()
}
