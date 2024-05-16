//
//  CityHeaderView.swift
//  FreshAir
//
//  Created by Cody Morley on 5/15/24.
//

import SwiftUI
import UIKit

class CityHeaderView: UIView {
    
    private let station: String
    private let latString: String
    private let longString: String
    private let cityLabel: UILabel
    private let latLabel: UILabel
    private let longLabel: UILabel
    private let stack: UIStackView
    
    

    init(frame: CGRect, station: String, lat: String, long: String) {
        self.station = station
        latString = lat
        longString = long
        cityLabel = UILabel()
        latLabel = UILabel()
        longLabel = UILabel()
        stack = UIStackView(frame: CGRect(x: frame.midX,
                                          y: frame.midY,
                                          width: frame.width,
                                          height: frame.height))
        
        super.init(frame: frame)
        
        clipsToBounds = true
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoder not implemented.")
    }
    
    private func setup() {
        backgroundColor = .clear
        configureLabels()
        configureStack()
        addSubviewsToStack()
    }
    
    private func addSubviewsToStack() {
        stack.addArrangedSubview(cityLabel)
        stack.addArrangedSubview(latLabel)
        stack.addArrangedSubview(longLabel)
    }
    
    
    private func configureCityLabel() {
        cityLabel.text = "\(station)"
        cityLabel.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.light)
        cityLabel.textAlignment = .center
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLabels() {
        configureCityLabel()
        configureLatLabel()
        configureLongLabel()
    }
    
    private func configureLatLabel() {
        latLabel.text = "Latitude: \(latString)"
        latLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        latLabel.textAlignment = .center
        latLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLongLabel() {
        longLabel.text = "Longitude: \(longString)"
        longLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        longLabel.textAlignment = .center
        longLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureStack() {
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        stack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stack.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }

}

class CityHeader_PreviewViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        self.view = CityHeaderView(frame: CGRect(origin: .zero,
                                                 size: CGSize(width: 100,
                                                              height: 100)),
                                   station: "Los Angeles, CA",
                                   lat: "\(AirData.mockAirData.city.geo[0])",
                                   long: "\(AirData.mockAirData.city.geo[1])")
    }
}

#Preview {
    CityHeader_PreviewViewController()
}
