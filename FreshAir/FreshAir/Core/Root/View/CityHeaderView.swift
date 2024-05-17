//
//  CityHeaderView.swift
//  FreshAir
//
//  Created by Cody Morley on 5/15/24.
//

import SwiftUI
import UIKit


class CityHeaderView: UIView {
    private let cityLabel: UILabel
    private let latLabel: UILabel
    private let longLabel: UILabel
    private let stack: UIStackView
    
    
    init(station: String, lat: String, long: String) {
        cityLabel = UILabel()
        cityLabel.text = station
        cityLabel.font = UIFont.systemFont(ofSize: 30, weight:.light)
        cityLabel.textAlignment = .center
        cityLabel.lineBreakMode = .byWordWrapping
        cityLabel.numberOfLines = 0
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        latLabel = UILabel()
        latLabel.text = "Latitude: \(lat)"
        latLabel.font = UIFont.systemFont(ofSize: 14, weight:.light)
        latLabel.textAlignment = .center
        latLabel.translatesAutoresizingMaskIntoConstraints = false
        
        longLabel = UILabel()
        longLabel.text = "Longitude: \(long)"
        longLabel.font = UIFont.systemFont(ofSize: 14, weight:.light)
        longLabel.textAlignment = .center
        longLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stack = UIStackView(arrangedSubviews: [cityLabel, latLabel, longLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame:.zero)
        
        clipsToBounds = true
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        backgroundColor = .clear
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}


class CityHeader_PreviewViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        self.view = CityHeaderView(station: "Los Angeles, CA",
                                   lat: "\(AirData.mockAirData.city.geo[0])",
                                   long: "\(AirData.mockAirData.city.geo[1])")
    }
}


#Preview {
    CityHeader_PreviewViewController()
}
