//
//  ForecastAirQualityView.swift
//  FreshAir
//
//  Created by Cody Morley on 5/15/24.
//

import UIKit

class ForecastAirQualityView: UIView {
    private let descriptionLabel: UILabel
    private let headerLabel: UILabel
    private let valueLabel: UILabel
    private let stack: UIStackView

    init(aqi: String, description: String, color: UIColor) {
        headerLabel = UILabel()
        headerLabel.text = "Tomorrow's Forecast:"
        headerLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        headerLabel.textAlignment = .center
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        valueLabel = UILabel()
        valueLabel.text = aqi
        valueLabel.font = UIFont.monospacedSystemFont(ofSize: 84, weight: UIFont.Weight.bold)
        valueLabel.textColor = .green
        valueLabel.textAlignment = .center
        valueLabel.backgroundColor = .clear
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.font = UIFont.monospacedSystemFont(ofSize: 14, weight: UIFont.Weight.bold)
        descriptionLabel.textColor = color
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stack = UIStackView(arrangedSubviews: [headerLabel, valueLabel, descriptionLabel])
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


class ForecastAirQualityView_PreviewViewController: UIViewController {
    override func viewDidLoad() {
        self.view = ForecastAirQualityView(aqi: "49",
                                            description: "High Air Quality",
                                            color: .green)
    }
}

#Preview {
    YesterdayAirQualityView_PreviewViewController()
}
