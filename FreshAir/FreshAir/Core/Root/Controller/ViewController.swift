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
    
    init(dataManager: AirQualityDataManaging = AirQualityDataManager()) {
        self.dataManager = dataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    private func setupSubviews() {
        setupBackground()
        setupCityLabel()
        setupAQILabel()
        
        
        
    }
    
    private func setupBackground() {
        let background = UIImageView(image: UIImage(named: "blue_skies"))
        view.addSubview(background)
        background.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        background.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        background.layer.zPosition = -1
    }
    
    private func setupAQILabel() {
        let aqiLabel = UILabel()
        aqiLabel.textAlignment = .center
        aqiLabel.text = "55"
        aqiLabel.font = UIFont.monospacedSystemFont(ofSize: 82, weight: UIFont.Weight.bold)
        aqiLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aqiLabel)
        aqiLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        aqiLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 234).isActive = true
    }
    
    private func setupCityLabel() {
        let cityLabel = UILabel()
        cityLabel.text = "Los Angeles, CA"
        cityLabel.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.light)
        cityLabel.textAlignment = .center
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cityLabel)
        cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cityLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 124).isActive = true
    }
}


#Preview {
    ViewController()
}
