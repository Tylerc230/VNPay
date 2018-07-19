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
import Stellar

class LoginViewController: UIViewController {
    @IBOutlet var triangleAnimationView: LOTAnimationView!
    @IBOutlet var userNameField: PillTextField!
    @IBOutlet var userNameWidth: NSLayoutConstraint!
    @IBOutlet var passwordField: PillTextField!
    @IBOutlet var passwordWidth: NSLayoutConstraint!
    @IBOutlet var loginButton: MDCButton!
    var userNameTextFieldController: TextInputControllerPill!
    var passwordTextFieldController: TextInputControllerPill!
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextFieldController = TextInputControllerPill(textInput: userNameField)
        passwordTextFieldController = TextInputControllerPill(textInput: passwordField)

        loginButton.shapeGenerator = MDCPillShapeGenerator()
        loginButton.setElevation(.raisedButtonResting, for: .normal)
        loginButton.setElevation(.raisedButtonPressed, for: .highlighted)

        triangleAnimationView.setAnimation(named: "triangle_animation.json")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        runShowAnimation()
    }
    
    @IBAction func loginTapped() {
        runShowAnimation()
    }
    
    func runShowAnimation() {
        let moveY = loginButton.frame.size.height/2
        userNameField.prepareAnimateIn()
        passwordField.prepareAnimateIn()
        loginButton.prepareAnimationIn(moveAmount: moveY)
        triangleAnimationView.play()
        triangleAnimationView.animationSpeed = 1.1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.userNameField.animateIn(to: self.userNameWidth.constant)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.passwordField.animateIn(to: self.passwordWidth.constant)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.loginButton.animateIn(moveAmount: moveY)
                }
            }
            
        }
    }
}

extension MDCButton {
    func prepareAnimationIn(moveAmount: CGFloat) {
        alpha = 0.0
        frame.origin.y += moveAmount
    }
    
    func animateIn(moveAmount: CGFloat) {
        makeAlpha(1.0)
            .moveY(-moveAmount)
            .duration(0.3)
            .animate()
    }
}

extension PillTextField {
    //maybe try sica instead
    func prepareAnimateIn() {
        frame.size.width = 45.0
        alpha = 0.0
    }
    func animateIn(to width: CGFloat) {
        let easing = TimingFunctionType.custom(0.33, 0.78, 0.34, 1.0)
        makeAlpha(1.0)
            .makeWidth(width)
            .duration(0.6)
            .easing(easing)
            .animate()
    }
}

