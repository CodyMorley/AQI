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
    let stack = UIStackView()
    
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
        configureStack()
        configureCityHeaderView()
        configureTodayAirQualityView()
        configureYesterdayAirQualityView()
        configureForecastAirQualityView()
    }
    
    private func configureStack() {
        stack.axis = .vertical
        stack.alignment = .fill // Changed from.center to.fill
        stack.spacing = 25
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.widthAnchor.constraint(equalTo: view.widthAnchor),
            stack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8)
        ])
    }
    
    private func configureCityHeaderView() {
        let header = CityHeaderView(station: "Los Angeles, CA",
                                    lat: "\(AirData.mockAirData.city.geo[0])",
                                    long: "\(AirData.mockAirData.city.geo[1])")
        header.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(header)
    }
    
    private func configureTodayAirQualityView() {
        let todayAirQualityView = TodayAirQualityView(aqi: String(AirData.mockAirData.aqi),
                                                      description: getTextDescription(for: AirData.mockAirData.aqi),
                                                      color: getAssociatedColor(for: AirData.mockAirData.aqi))
        
        todayAirQualityView.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(todayAirQualityView)
    }
    
    private func configureBackground() {
        let background = UIImageView(image: UIImage(named: "blue_skies"))
        view.addSubview(background)
        background.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        background.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        background.layer.zPosition = -2
    }
    
    private func configureYesterdayAirQualityView() {
        let yesterdayAirView = YesterdayAirQualityView(aqi: "49",
                                                       description: getTextDescription(for: 49),
                                                       color: getAssociatedColor(for: 49))
        yesterdayAirView.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(yesterdayAirView)
        
    }
    
    private func configureForecastAirQualityView() {
        let tomorrowView = ForecastAirQualityView(aqi: "21",
                                                  description: getTextDescription(for: 21),
                                                  color: getAssociatedColor(for: 21))
        tomorrowView.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(tomorrowView)
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
