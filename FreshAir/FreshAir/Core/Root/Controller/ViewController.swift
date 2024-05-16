//
//  ViewController.swift
//  FreshAir
//
//  Created by Cody Morley on 5/14/24.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    var dataManager: AirQualityDataManaging
    private(set) var cityLabel = UILabel()
    private(set) var aqiLabel = UILabel()
    private(set) var aqiIndicator = UIView()
    private(set) var yesterdayHeaderLabel = UILabel()
    private(set) var yesterdayValueLabel = UILabel()
    private(set) var yesterdayIndicator = UIView()
    private(set) var tomorrowHeaderLabel = UILabel()
    private(set) var tomorrowValueLabel = UILabel()
    private(set) var tomorrowIndicator = UIView()
    
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
        configureAQILabel()
        configureAQIIndicatorView()
        configureYesterdayHeaderLabel()
        configureYesterdayValueLabel()
        configureTomorrowHeaderLabel()
        configureTomorrowValueLabel()
        configureForecastIndicatorViews()
    }
    
    private func configureAQILabel() {
        aqiLabel.textAlignment = .center
        aqiLabel.text = "55"
        aqiLabel.font = UIFont.monospacedSystemFont(ofSize: 84, weight: UIFont.Weight.bold)
        aqiLabel.backgroundColor = .clear
        aqiLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aqiLabel)
        aqiLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        aqiLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 234).isActive = true
    }
    
    private func configureAQIIndicatorView() {
        aqiIndicator.backgroundColor = .yellow
        aqiIndicator.clipsToBounds = true
        aqiIndicator.layer.zPosition = -1
        aqiIndicator.layer.cornerRadius = (aqiLabel.frame.height * 1.05) / 2
        aqiIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aqiIndicator)
        aqiIndicator.centerXAnchor.constraint(equalTo: aqiLabel.centerXAnchor).isActive = true
        aqiIndicator.centerYAnchor.constraint(equalTo: aqiLabel.centerYAnchor).isActive = true
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
        cityLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 124).isActive = true
    }
    
    private func configureForecastIndicatorViews() {
        // configure yesterday indicator
        
        // configure tomrrow indicator
    }
    
    private func configureTomorrowHeaderLabel() {
        tomorrowHeaderLabel.text = "Tomorrow's Forecast:"
        tomorrowHeaderLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        tomorrowHeaderLabel.textAlignment = .center
        tomorrowHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tomorrowHeaderLabel)
        tomorrowHeaderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tomorrowHeaderLabel.topAnchor.constraint(equalTo: yesterdayHeaderLabel.bottomAnchor, constant: 136).isActive = true
    }
    
    private func configureTomorrowValueLabel() {
        tomorrowValueLabel.textAlignment = .center
        tomorrowValueLabel.text = "21"
        tomorrowValueLabel.font = UIFont.monospacedSystemFont(ofSize: 84, weight: UIFont.Weight.bold)
        tomorrowValueLabel.backgroundColor = .clear
        tomorrowValueLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tomorrowValueLabel)
        tomorrowValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tomorrowValueLabel.topAnchor.constraint(equalTo: tomorrowHeaderLabel.bottomAnchor, constant: 4).isActive = true
    }
    
    private func configureYesterdayHeaderLabel() {
        yesterdayHeaderLabel.text = "Compare to Yesterday:"
        yesterdayHeaderLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        yesterdayHeaderLabel.textAlignment = .center
        yesterdayHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(yesterdayHeaderLabel)
        yesterdayHeaderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        yesterdayHeaderLabel.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func configureYesterdayValueLabel() {
        yesterdayValueLabel.textAlignment = .center
        yesterdayValueLabel.text = "49"
        yesterdayValueLabel.font = UIFont.monospacedSystemFont(ofSize: 84, weight: UIFont.Weight.bold)
        yesterdayValueLabel.backgroundColor = .clear
        yesterdayValueLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(yesterdayValueLabel)
        yesterdayValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        yesterdayValueLabel.topAnchor.constraint(equalTo: yesterdayHeaderLabel.bottomAnchor, constant: 4).isActive = true
    }
}


#Preview {
    ViewController()
}
