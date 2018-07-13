//
//  ViewController.swift
//  VNPay
//
//  Created by Tyler Casselman on 7/10/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import UIKit
import Lottie
import MaterialComponents

class LoginViewController: UIViewController {
    @IBOutlet var triangleAnimationView: LOTAnimationView!
    @IBOutlet var userNameField: PillTextField!
    var userNameTextFieldController: MDCTextInputControllerFilled!
    override func viewDidLoad() {
        super.viewDidLoad()
//        userNameTextFieldController = MDCTextInputControllerFilled(textInput: userNameField)
//        userNameTextFieldController.roundedCorners = .allCorners
//        userNameTextFieldController.borderFillColor = .white
//        userNameTextFieldController.underlineHeightNormal = 0.0
//        userNameTextFieldController.underlineHeightActive = 0.0

        
        
        triangleAnimationView.setAnimation(named: "triangle_animation.json")
        triangleAnimationView.play()
    }
}

