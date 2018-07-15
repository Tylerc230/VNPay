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
    @IBOutlet var userNameWidth: NSLayoutConstraint!
    @IBOutlet var passwordField: PillTextField!
    @IBOutlet var passwordWidth: NSLayoutConstraint!
    var userNameTextFieldController: TextInputControllerPill!
    var passwordTextFieldController: TextInputControllerPill!
    @IBOutlet var  loginButton: MDCButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextFieldController = TextInputControllerPill(textInput: userNameField)
        passwordTextFieldController = TextInputControllerPill(textInput: passwordField)
        
        loginButton.shapeGenerator = MDCPillShapeGenerator()
        loginButton.setElevation(.raisedButtonResting, for: .normal)
        loginButton.setElevation(.raisedButtonPressed, for: .highlighted)
        
        triangleAnimationView.setAnimation(named: "triangle_animation.json")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
        runShowAnimation()
    }
    
    func runShowAnimation() {
        triangleAnimationView.play()
        NSLayoutConstraint.activate([passwordWidth, userNameWidth])
        UIView.animate(withDuration: 1.5) {
            self.view.layoutIfNeeded()
        }
    }
}

