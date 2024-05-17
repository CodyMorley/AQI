//
//  ResetLocationViewController.swift
//  FreshAir
//
//  Created by Cody Morley on 5/17/24.
//

import CoreLocation
import UIKit

class ResetLocationViewController: UIViewController {
    var longField = UITextField()
    var latField = UITextField()
    let dataManager: AirQualityDataManaging
    
    init(dataManager: AirQualityDataManaging) {
        self.dataManager = dataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Coder Not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let backgroundView = UIView(frame: self.view.bounds)
        backgroundView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backgroundView)
        
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
        longField = UITextField(frame: CGRect(x: 20, y: 100, width: self.view.frame.width - 40, height: 40))
        longField.placeholder = "Longitude"
        longField.borderStyle = .roundedRect
        longField.translatesAutoresizingMaskIntoConstraints = false
        
        latField = UITextField(frame: CGRect(x: 20, y: 150, width: self.view.frame.width - 40, height: 40))
        latField.placeholder = "Latitude"
        latField.borderStyle = .roundedRect
        latField.translatesAutoresizingMaskIntoConstraints = false
        
        let changeLocationButton = UIButton(type:.system)
        changeLocationButton.setTitle("Change Location", for: .normal)
        changeLocationButton.setTitleColor(.white, for:.normal)
        changeLocationButton.backgroundColor = .blue
        changeLocationButton.layer.cornerRadius = 5
        changeLocationButton.addTarget(self, action: #selector(changeLocation), for:.touchUpInside)
        changeLocationButton.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.addSubview(longField)
        backgroundView.addSubview(latField)
        backgroundView.addSubview(changeLocationButton)
        
        NSLayoutConstraint.activate([
            longField.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 50),
            longField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            
            latField.topAnchor.constraint(equalTo: longField.bottomAnchor, constant: 10),
            latField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            
            changeLocationButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            changeLocationButton.topAnchor.constraint(equalTo: latField.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func changeLocation() async {
        print("Change Location Button Tapped")
        guard let lat = Double(latField.text ?? "00.00") else { return }
        guard let long = Double(longField.text ?? "00.00") else { return }
        
        let loc = CLLocation(latitude: lat, longitude: long)
        Task { await dataManager.fetchAirData() }
        self.dismiss(animated: true)
    }
}

#Preview {
    ResetLocationViewController(dataManager: MockAirQualityDataManager())
}
