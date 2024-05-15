//
//  ViewController.swift
//  FreshAir
//
//  Created by Cody Morley on 5/14/24.
//

import UIKit
<<<<<<< HEAD
import SwiftUI

class ViewController: UIViewController {
    
    let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    private func setupSubviews() {
        
        let background = UIImageView(image: UIImage(named: "blue_skies"))
        view.addSubview(background)
        background.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        background.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        background.layer.zPosition = -1
        
    }
}


#Preview {
    ViewController()
}
=======

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
}

>>>>>>> 951c642b5ec216ea3724e73ba27bd05f359d4892
