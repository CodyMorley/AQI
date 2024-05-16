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
    private var header: CityHeaderView?
    private var today: TodayAirQualityView?
    private var yesterday: YesterdayAirQualityView?
    private var tomorrow: ForecastAirQualityView?
    private var dataManager: AirQualityDataManaging
    private let headerHeight: CGFloat = 128
    private let spaceConstant: CGFloat = 116
    
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
        createAndAddSubViews()
        activateConstraints()
    }
    
    private func activateConstraints() {
        guard let header, let today, let yesterday, let tomorrow else { return }
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.heightAnchor.constraint(equalToConstant: headerHeight),
            today.topAnchor.constraint(equalTo: header.bottomAnchor, constant: spaceConstant),
            today.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            today.heightAnchor.constraint(equalToConstant: 48),
            yesterday.topAnchor.constraint(equalTo: today.bottomAnchor, constant: spaceConstant),
            yesterday.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yesterday.heightAnchor.constraint(equalToConstant: 48),
            tomorrow.topAnchor.constraint(equalTo: yesterday.bottomAnchor, constant: spaceConstant),
            tomorrow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tomorrow.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func configureBackground() {
        let background = UIImageView(image: UIImage(named: "blue_skies"))
        background.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(background)
        NSLayoutConstraint.activate([
            background.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            background.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        background.layer.zPosition = -2
    }
    
    private func createAndAddSubViews() {
        self.header = CityHeaderView(station: "Los Angeles, CA",
                                     lat: "\(AirData.mockAirData.city.geo[0])",
                                     long: "\(AirData.mockAirData.city.geo[1])")
        self.today = TodayAirQualityView(aqi: String(AirData.mockAirData.aqi),
                                         description: getTextDescription(for: AirData.mockAirData.aqi),
                                         color: getAssociatedColor(for: AirData.mockAirData.aqi))
        self.yesterday = YesterdayAirQualityView(aqi: "49",
                                                 description: getTextDescription(for: 49),
                                                 color: getAssociatedColor(for: 49))
        self.tomorrow = ForecastAirQualityView(aqi: "21",
                                               description: getTextDescription(for: 21),
                                               color: getAssociatedColor(for: 21))
        header?.translatesAutoresizingMaskIntoConstraints = false
        today?.translatesAutoresizingMaskIntoConstraints = false
        yesterday?.translatesAutoresizingMaskIntoConstraints = false
        tomorrow?.translatesAutoresizingMaskIntoConstraints = false
        
        if let header, let today, let tomorrow, let yesterday {
            view.addSubview(header)
            view.addSubview(today)
            view.addSubview(yesterday)
            view.addSubview(tomorrow)
        }
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
