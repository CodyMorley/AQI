//
//  ViewController.swift
//  FreshAir
//
//  Created by Cody Morley on 5/14/24.
//

import Combine
import UIKit
import SwiftUI


class OverviewViewController: UIViewController {
    private(set) var activityIndicator: UIActivityIndicatorView?
    private(set) var header: CityHeaderView?
    private(set) var today: TodayAirQualityView?
    private(set) var yesterday: YesterdayAirQualityView?
    private(set) var tomorrow: ForecastAirQualityView?
    private(set) var dataManager: AirQualityDataManaging
    private(set) var cancelBag = Set<AnyCancellable>()
    private let configurationManager = ViewConfigurationManager()
    private let headerHeight: CGFloat = 152
    private let spaceConstant: CGFloat = 108
    
    
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
        configureSubviewState(withData: dataManager.publisher.value)
    }
    
    private func activateConstraints() {
        if let header, let today, let yesterday, let tomorrow {
            NSLayoutConstraint.activate([
                header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                header.heightAnchor.constraint(equalToConstant: headerHeight),
                header.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90),
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
    
    private func configureButton() {
        let changeLocationButton = UIButton()
        changeLocationButton.setTitle("Change Location", for: .normal)
        changeLocationButton.backgroundColor = .blue
        changeLocationButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        changeLocationButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(changeLocationButton)
        
        NSLayoutConstraint.activate([
            changeLocationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
    }
    
    private func configureDataSubviews(withData data: AirData) {
        header = CityHeaderView(station: data.city.name,
                                lat: "\(data.city.geo[0])",
                                long: "\(data.city.geo[1])")
        header?.translatesAutoresizingMaskIntoConstraints = false
        
        let todayConfig = configurationManager.getConfiguration(forAQI: data.aqi)
        let yesterdayConfig = configurationManager.getConfiguration(forAQI: data.forecast.daily["pm25"]?[0].avg ?? 00)
        let tomorrowConfig = configurationManager.getConfiguration(forAQI: data.forecast.daily["pm25"]?[2].avg ?? 00)
        today = TodayAirQualityView(config: todayConfig)
        today?.translatesAutoresizingMaskIntoConstraints = false
        yesterday = YesterdayAirQualityView(config: yesterdayConfig)
        yesterday?.translatesAutoresizingMaskIntoConstraints = false
        tomorrow = ForecastAirQualityView(config: tomorrowConfig)
        tomorrow?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureSubviewState(withData data: AirData?) {
        configureBackground()
        configureButton()
        createAndAddStateSubviews(withData: data)
        activateConstraints()
    }
    
    private func createAndAddStateSubviews(withData data: AirData?) {
        guard let data else {
            configureActivityIndicator()
            header?.removeFromSuperview()
            today?.removeFromSuperview()
            yesterday?.removeFromSuperview()
            tomorrow?.removeFromSuperview()
            header = nil
            today = nil
            yesterday = nil
            tomorrow = nil
            addStateSubviews()
            return
        }
        configureDataSubviews(withData: data)
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
    
    func updateViews(_ data: AirData?) {
        guard let data = data else { return }
        configureSubviewState(withData: data)
        view.setNeedsDisplay()
    }
    
    @objc func buttonTapped() {
        let popoverVC = ResetLocationViewController(dataManager: dataManager)
        popoverVC.modalPresentationStyle = .overCurrentContext
        popoverVC.modalTransitionStyle = .crossDissolve
        self.present(popoverVC, animated: true, completion: nil)
    }
}

#Preview {
    OverviewViewController()
}
