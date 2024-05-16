//
//  AQICardView.swift
//  FreshAir
//
//  Created by Cody Morley on 5/15/24.
//

import SwiftUI
import UIKit

class AQICardView: UIView {

    private let aqi: Int
    private let city: String
    private var aqiColor: UIColor {
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
    private var qualityDescription: String {
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
    
    
    init(frame: CGRect, aqi: Int, city: String) {
        self.aqi = aqi
        self.city = city
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupSubviews() {
        let interfaceStyle = traitCollection.userInterfaceStyle
        let textColor: UIColor = interfaceStyle == .light ? .black : .white
        
        backgroundColor = UIColor.systemBackground
        
        let cityLabel = UILabel(frame: CGRect(x: 0, y: 4, width: bounds.width, height: 24))
        cityLabel.text = city
        cityLabel.textColor = textColor
        cityLabel.textAlignment = .center
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(cityLabel)
        
        let aqiLabel = UILabel(frame: CGRect(x: 0, y: 32, width: 36, height: 36))
        aqiLabel.text = String(aqi)
        aqiLabel.textAlignment = .center
        aqiLabel.layer.zPosition = 2
        aqiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(aqiLabel)
        
        let aqiCircle = UIView(frame: CGRect(x: 0, y: 0, width: 42, height: 42))
       
        aqiCircle.layer.cornerRadius = aqiCircle.frame.size.width / 2
        aqiCircle.clipsToBounds = true
        aqiCircle.backgroundColor = aqiColor
        addSubview(aqiCircle)
        aqiCircle.centerXAnchor.constraint(equalTo: aqiLabel.centerXAnchor).isActive = true
    }
    
}


#Preview {
    AQICardView(frame: CGRect(x: 4,
                              y: 4,
                              width: 200,
                              height: 100),
                aqi: 35,
                city: "Los Angeles")
}
