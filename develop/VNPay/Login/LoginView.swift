//
//  LoginView.swift
//  VNPay
//
//  Created by Tyler Casselman on 7/26/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import Foundation
import Lottie
import MaterialComponents
import Stellar

fileprivate let logoHideTransform = CGAffineTransform.identity.translatedBy(x: 0.0, y: -49).scaledBy(x: 0.65, y: 0.65)

class LoginView: UIView {
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

    override func awakeFromNib() {
         super.awakeFromNib()
        userNameTextFieldController = TextInputControllerPill(textInput: userNameField)
        passwordTextFieldController = TextInputControllerPill(textInput: passwordField)
        userNameField.set(leftIcon: "", isRegular: true)
        passwordField.set(leftIcon: "", isRegular: false)
        
        loginButton.shapeGenerator = MDCPillShapeGenerator()
        loginButton.setElevation(.raisedButtonResting, for: .normal)
        loginButton.setElevation(.raisedButtonPressed, for: .highlighted)
        
        triangleAnimationView.setAnimation(named: "triangle_animation.json")
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
            self.userNameField.animate(to: self.userNameWidth.constant, duration: 0.6).animate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.passwordField.animate(to: self.passwordWidth.constant, duration: 0.6).animate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.loginButton.animateIn(moveAmount: moveY, duration: 0.4)
                    self.animateButtomButtons()
                }
            }
            
        }
    }
    
    func runDismissAnimation(complete: @escaping () -> ()) {
//        these 2 calls make the login button jump
        userNameField.showContents = false
        passwordField.showContents = false
        let fieldDuration = 0.21
        userNameField
            .animate(to: 45.0, duration: fieldDuration)
            .then()
            .makeAlpha(0.0)
            .animate()
        passwordField
            .animate(to: 45.0, duration: fieldDuration)
            .then()
            .makeAlpha(0.0)
            .animate()
        hideBottomButtons()
        UIView.animate(withDuration: 0.4) {
            self.logo.transform = logoHideTransform
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + fieldDuration - 0.06) {
            self.triangleAnimationView.animationSpeed = -3.3;
            self.triangleAnimationView.play()
            self.loginButton
                .makeAlpha(0.0)
                .duration(0.06)
                .completion(complete)
                .animate()
        }
    }
    
    private func prepareButtonButtonAnimation() {
        let buttons = bottomButtons.arrangedSubviews
        buttons.forEach{ $0.prepareAnimationIn(moveAmount: 10.0) }
    }
    
    private func prepareLogoAnimation() {
        logo.transform = logoHideTransform
    }
    
    private func animateLogo() {
        UIView.animate(withDuration: 0.4) {
            self.logo.transform = .identity
        }
    }
    
    private func animateButtomButtons() {
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
    
    private func hideBottomButtons() {
        bottomButtons
            .makeAlpha(0.0)
            .duration(0.15)
            .moveY(bottomButtons.frame.height)
            .animate()
    }
}

fileprivate extension UIView {
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

fileprivate extension PillTextField {
    func prepareAnimateIn() {
        frame.size.width = 45.0
        alpha = 0.0
    }
    
    func animate(to width: CGFloat, duration: CFTimeInterval) -> Self {
        let easing = TimingFunctionType.custom(0.33, 0.78, 0.34, 1.0)
        return makeAlpha(1.0)
            .makeWidth(width)
            .duration(duration)
            .easing(easing)
    }
}
