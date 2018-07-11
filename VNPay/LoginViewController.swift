//
//  ViewController.swift
//  VNPay
//
//  Created by Tyler Casselman on 7/10/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import UIKit
import Lottie

class LoginViewController: UIViewController {
    @IBOutlet var triangleAnimationView: LOTAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        triangleAnimationView.setAnimation(named: "triangle_animation.json")
        triangleAnimationView.play()
    }
}

