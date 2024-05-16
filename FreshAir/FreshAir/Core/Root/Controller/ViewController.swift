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

import Combine
import UIKit
import SwiftUI

class ViewController: UIViewController {
    private var activityIndicator: UIActivityIndicatorView?
    private var header: CityHeaderView?
    private var today: TodayAirQualityView?
    private var yesterday: YesterdayAirQualityView?
    private var tomorrow: ForecastAirQualityView?
    private var dataManager: AirQualityDataManaging
    private var cancelBag = Set<AnyCancellable>()
    private let headerHeight: CGFloat = 128
    private let spaceConstant: CGFloat = 116
    
    init(dataManager: AirQualityDataManaging = AirQualityDataManager()) {
        self.dataManager = dataManager
        super.init(nibName: nil, bundle: nil)
        subscribeToData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews(withData: dataManager.publisher.value)
    }
    
    
    private func activateConstraints() {
        if let header, let today, let yesterday, let tomorrow {
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
        } else if let activityIndicator {
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }
    
    private func addStateSubviews() {
        if let header, let today, let tomorrow, let yesterday {
            view.addSubview(header)
            view.addSubview(today)
            view.addSubview(yesterday)
            view.addSubview(tomorrow)
        } else if let activityIndicator {
            view.addSubview(activityIndicator)
        }
    }
    
    private func configureActivityIndicator() {
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        
        guard let activityIndicator else { return }
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
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
    
    private func configureSubviews(withData data: AirData?) {
        configureBackground()
        createAndAddSubviews(withData: data)
        activateConstraints()
    }
    
    private func createAndAddSubviews(withData data: AirData?) {
        guard let data else {
            configureActivityIndicator()
            header?.removeFromSuperview()
            header = nil
            today?.removeFromSuperview()
            today = nil
            yesterday?.removeFromSuperview()
            yesterday = nil
            tomorrow?.removeFromSuperview()
            tomorrow = nil
            addStateSubviews()
            return
        }
        header = CityHeaderView(station: data.city.name,
                                lat: "\(data.city.geo[0])",
                                long: "\(data.city.geo[1])")
        header?.translatesAutoresizingMaskIntoConstraints = false
        today = TodayAirQualityView(aqi: "\(data.aqi)",
                                    description: getTextDescription(for: data.aqi),
                                    color: getAssociatedColor(for: data.aqi))
        today?.translatesAutoresizingMaskIntoConstraints = false
        yesterday = YesterdayAirQualityView(aqi: "\(data.forecast.daily["pm25"]?[0].avg ?? 00)",
                                            description: getTextDescription(for: data.forecast.daily["pm25"]?[0].avg ?? -1),
                                            color: getAssociatedColor(for: data.forecast.daily["pm25"]?[0].avg ?? -1))
        yesterday?.translatesAutoresizingMaskIntoConstraints = false
        tomorrow = ForecastAirQualityView(aqi: "\(data.forecast.daily["pm25"]?[2].avg ?? 00)",
                                          description: getTextDescription(for: data.forecast.daily["pm25"]?[2].avg ?? -1),
                                          color: getAssociatedColor(for: data.forecast.daily["pm25"]?[2].avg ?? -1))
        tomorrow?.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
        addStateSubviews()
    }
    
    private func subscribeToData() {
        dataManager.publisher.receive(on: RunLoop.main)
            .sink { [weak self] data in
                guard let self else { return }
                self.updateViews(data)
            }
            .store(in: &cancelBag)
    }
    
    private func updateViews(_ data: AirData?) {
        guard let data = data else { return }
        configureSubviews(withData: data)
        view.setNeedsDisplay()
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
