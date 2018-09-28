//
//  LoginView.swift
//  VNPay
//
//  Created by Tyler Casselman on 7/26/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import UIKit
import Lottie
import Choreo
import Disco

class LoginView: UIView {
    @IBOutlet var triangleAnimationView: LOTAnimationView!
    @IBOutlet var logo: UIImageView!
    @IBOutlet var userNameField: PillTextField!
    @IBOutlet var userNameWidth: NSLayoutConstraint!
    @IBOutlet var passwordField: PillTextField!
    @IBOutlet var passwordWidth: NSLayoutConstraint!
    @IBOutlet var loginButton: PillButton!
    @IBOutlet var bottomButtons: UIStackView!
    override func awakeFromNib() {
         super.awakeFromNib()
        userNameField.set(leftIcon: "", isRegular: true)
        passwordField.set(leftIcon: "", isRegular: false)
        passwordField.set(rightIcon: "", isRegular: true)
        
        triangleAnimationView.setAnimation(named: "triangle_animation.json")
    }
    
    func runShowAnimation() {
        let moveY = loginButton.frame.size.height/2
        
        Choreo()
            .prepareAnimations {
                self.userNameField.prepareAnimateIn()
                self.passwordField.prepareAnimateIn()
                self.userNameWidth.isActive = false
                self.passwordWidth.isActive = false
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
                _ = self.userNameField
                    .animate(duration: duration)
                    .addAnimationBlock { view in
                        self.userNameWidth.isActive = true
                        view.layoutIfNeeded()
                    }
                    .start()
            }
            .addAnimationPhase(startFraction: 0.7, durationFraction: 0.1) { duration in
                self.userNameField.showContents = true
                self.passwordField.showContents = true
            }
            .addAnimationPhase(startFraction: 0.3, durationFraction: 0.7) { duration in
                _ = self.passwordField
                    .animate(duration: duration)
                    .addAnimationBlock { view in
                        self.passwordWidth.isActive = true
                        view.layoutIfNeeded()
                    }.start()
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
            .addAnimationPhase(startFraction: 0.0, durationFraction: 1.0) { duration in
                UIView.animate(withDuration: duration) {
                    self.logo.transform = logoHideTransform
                }
            }
            .addAnimationPhase(startFraction: 0.0, durationFraction: 0.3) { duration in
                _ = self.userNameField
                    .animate(duration: duration)
                    .setTiming(.predefined(.easeOut))
                    .addAnimationBlock { view in
                        self.userNameWidth.isActive = false
                        view.layoutIfNeeded()
                    }
                    .then()
                    //seems like this alpha fade isn't happening after the shrink
                    .setAlpha(to:0.0)
                    .start()
                _ = self.passwordField
                    .animate(duration: duration)
                    .setTiming(.predefined(.easeOut))
                    .addAnimationBlock { view in
                        self.passwordWidth.isActive = false
                        view.layoutIfNeeded()
                    }
                    .then()
                    .setAlpha(to:0.0)
                    .start()
            }
            .addAnimationPhase(startFraction: 0.35, durationFraction: 0.15) { duration in
                self.triangleAnimationView.animationSpeed = -3.3;
                self.triangleAnimationView.play()
                _ = self.loginButton.disco
                    .setAlpha(to: 0.0)
                    .duration(duration)
                    .start()
            }
            .addAnimationPhase(startFraction: 0.0, durationFraction: 0.375) { duration in
                _ = self.bottomButtons.disco
                    .setAlpha(to: 0.0)
                    .duration(duration)
                    .setTransform(to: CGAffineTransform(translationX: 0.0, y: self.bottomButtons.frame.height))
                    .start()
            }
            .onComplete(complete)
            .animate(totalDuration: 2.4)
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
        transform = CGAffineTransform(translationX: 0.0, y: moveAmount)
    }
    
    func animateIn(moveAmount: CGFloat, duration: TimeInterval) {
        _ = disco
            .setTiming(.bezier(CGPoint(x: 0.33, y: 0.78), CGPoint(x: 0.34, y:1.0)))
            .duration(duration)
            .setAlpha(to: 1.0)
            .setTransform(to: .identity)
            .start()
    }
}

fileprivate extension PillTextField {
    func prepareAnimateIn() {
        alpha = 0.0
        showContents = false

    }
    
    func animate(duration: CFTimeInterval) -> AnimationSequence {
        return disco
            .duration(duration)
            .setTiming(.bezier(CGPoint(x: 0.33, y: 0.79), CGPoint(x: 0.34, y: 1.0)))
            .setAlpha(to: 1.0)
    }
}
