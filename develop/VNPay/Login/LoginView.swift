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
    @IBOutlet var loginButton: PillButton!
    @IBOutlet var bottomButtons: UIStackView!
    var userNameTextFieldController: TextInputControllerPill!
    var passwordTextFieldController: TextInputControllerPill!
    override func awakeFromNib() {
         super.awakeFromNib()
        userNameTextFieldController = TextInputControllerPill(textInput: userNameField)
        passwordTextFieldController = TextInputControllerPill(textInput: passwordField)
        userNameField.set(leftIcon: "", isRegular: true)
        passwordField.set(leftIcon: "", isRegular: false)
        
        triangleAnimationView.setAnimation(named: "triangle_animation.json")
    }
    
    func runShowAnimation() {
        let moveY = loginButton.frame.size.height/2
        
        Choreo()
            .prepareAnimations {
                self.userNameField.prepareAnimateIn()
                self.passwordField.prepareAnimateIn()
                self.loginButton.prepareAnimationIn(moveAmount: moveY)
                self.prepareButtonButtonAnimation()
                self.logo.transform = logoHideTransform
            }
            .addAnimationPhase(startFraction: 0.0, durationFraction: 0.5) { duration in
                self.animateLogo(duration: duration)
                self.triangleAnimationView.play()
                self.triangleAnimationView.animationSpeed = 1.1
            }
            .addAnimationPhase(startFraction: 0.2, durationFraction: 0.7) { duration in
                self.userNameField.animate(to: self.userNameWidth.constant, duration: duration).animate()
            }
            .addAnimationPhase(startFraction: 0.3, durationFraction: 0.7) { duration in
                self.passwordField.animate(to: self.passwordWidth.constant, duration: duration).animate()
            }
            .addAnimationPhase(startFraction: 0.5, durationFraction: 0.5){ duration in
                self.loginButton.animateIn(moveAmount: moveY, duration: duration)
            }
            .addStaggeredAnimation(views: bottomButtons.arrangedSubviews, startFraction: 0.5, durationFraction: 0.5, delayFraction: 0.2) { (view, duration) in
                view.animateIn(moveAmount: 10.0, duration: duration)
            }
            .animate(totalDuration: 0.85)
    }
    
    func runDismissAnimation(complete: @escaping () -> ()) {
        Choreo()
            .prepareAnimations {
                self.userNameField.showContents = false
                self.passwordField.showContents = false
            }
            .addAnimationPhase(startFraction: 0.0, durationFraction: 0.5) { duration in
                self.userNameField
                    .animate(to: 45.0, duration: duration)
                    .then()
                    .makeAlpha(0.0)
                    .animate()
                self.passwordField
                    .animate(to: 45.0, duration: duration)
                    .then()
                    .makeAlpha(0.0)
                    .animate()
            }
            .addAnimationPhase(startFraction: 0.0, durationFraction: 0.375) { duration in
                self.bottomButtons
                    .makeAlpha(0.0)
                    .duration(duration)
                    .moveY(self.bottomButtons.frame.height)
                    .animate()
            }
            .addAnimationPhase(startFraction: 0.35, durationFraction: 0.15) { duration in
                self.triangleAnimationView.animationSpeed = -3.3;
                self.triangleAnimationView.play()
                self.loginButton
                    .makeAlpha(0.0)
                    .duration(duration)
                    .completion(complete)
                    .animate()
            }
            .addAnimationPhase(startFraction: 0.0, durationFraction: 1.0) { duration in
                UIView.animate(withDuration: duration) {
                    self.logo.transform = logoHideTransform
                }
        }
        .animate(totalDuration: 0.4)
    }
    
    private func prepareButtonButtonAnimation() {
        let buttons = bottomButtons.arrangedSubviews
        buttons.forEach{ $0.prepareAnimationIn(moveAmount: 10.0) }
    }
    
    private func animateLogo(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.logo.transform = .identity
        }
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
