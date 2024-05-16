//
//  TodayAirQualityView.swift
//  FreshAir
//
//  Created by Cody Morley on 5/15/24.
//

import SwiftUI
import UIKit

class TodayAirQualityView: UIView {
    private let stack: UIStackView
    private let aqiLabel: UILabel
    private let aqiDescriptionLabel: UILabel
    
    
    init(aqi: String, description: String, color: UIColor) {
        aqiLabel = UILabel()
        aqiLabel.text = aqi
        aqiLabel.font = UIFont.monospacedSystemFont(ofSize: 84, weight: UIFont.Weight.bold)
        aqiLabel.textAlignment = .center
        aqiLabel.textColor = color
        aqiLabel.backgroundColor = .clear
        aqiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        aqiDescriptionLabel = UILabel()
        aqiDescriptionLabel.text = description
        aqiDescriptionLabel.font = UIFont.monospacedSystemFont(ofSize: 14, weight: UIFont.Weight.bold)
        aqiDescriptionLabel.textColor = color
        aqiDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        stack = UIStackView(arrangedSubviews: [aqiLabel, aqiDescriptionLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoder not implemented.")
    }
    
    
    private func setup() {
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

class TodayAirQualityView_PreviewViewController: ViewController {
    override func viewDidLoad() {
        self.view = TodayAirQualityView(aqi: "45",
                                        description: "High Air Quality",
                                        color: .green)
    }
}

#Preview {
    TodayAirQualityView_PreviewViewController()
}
