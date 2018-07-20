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
    @IBOutlet var logo: UIImageView!
    @IBOutlet var userNameField: PillTextField!
    @IBOutlet var userNameWidth: NSLayoutConstraint!
    @IBOutlet var passwordField: PillTextField!
    @IBOutlet var passwordWidth: NSLayoutConstraint!
    @IBOutlet var loginButton: MDCButton!
    @IBOutlet var bottomButtons: UIStackView!
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
        prepareButtonButtonAnimation()
        prepareLogoAnimation()
        
        animateLogo()
        triangleAnimationView.play()
        triangleAnimationView.animationSpeed = 1.1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.userNameField.animateIn(to: self.userNameWidth.constant)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.passwordField.animateIn(to: self.passwordWidth.constant)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.loginButton.animateIn(moveAmount: moveY, duration: 0.4)
                    self.animateButtomButtons()
                }
            }
            
        }
    }
    
    func prepareButtonButtonAnimation() {
        let buttons = bottomButtons.arrangedSubviews
        buttons.forEach{ $0.prepareAnimationIn(moveAmount: 10.0) }
    }
    
    func prepareLogoAnimation() {
        logo.transform = CGAffineTransform(scaleX: 0.9, y: 0.9).translatedBy(x: 0.0, y: -20)
    }
    
    func animateLogo() {
        UIView.animate(withDuration: 0.4) {
            self.logo.transform = .identity
        }
    }
    
    func animateButtomButtons() {
        let buttons = bottomButtons.arrangedSubviews
        let totalAnimationTime = 0.4
        let buttonAnimationTime = 0.2
        let buttonDelay = (totalAnimationTime - buttonAnimationTime)/Double(buttons.count)
        buttons.enumerated().forEach { args in
            let (offset, button) = args
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(offset) * buttonDelay) {
                button.animateIn(moveAmount: 10.0, duration: buttonAnimationTime)
            }
        }
    }
}

extension UIView {
    func prepareAnimationIn(moveAmount: CGFloat) {
        alpha = 0.0
        frame.origin.y += moveAmount
    }
    
    func animateIn(moveAmount: CGFloat, duration: TimeInterval) {
        let easing = TimingFunctionType.custom(0.33, 0.78, 0.34, 1.0)
        makeAlpha(1.0)
            .moveY(-moveAmount)
            .easing(easing)
            .duration(duration)
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

