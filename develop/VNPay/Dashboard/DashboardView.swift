//
//  DashboardView.swift
//  VNPay
//
//  Created by Tyler Casselman on 10/15/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import UIKit
import Choreo
import Disco
class DashboardView: UIView {
    @IBOutlet var balanceView: UIView!
    @IBOutlet var logo: UIImageView!
    @IBOutlet var hamburgerButton: UILabel!
    @IBOutlet var shareButton: UILabel!
    @IBOutlet var columns: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        logo.transform = logoHideTransform
    }
    
    func layoutButtons(withTarget target: DashboardViewController) {
        let buttons = [[("My Profile", ""), ("Transaction Report", ""), ("Other", "")],
                       [("Fund Transfer", ""), ("Register", ""), ("Search", "")],
                       [("Payment", ""), ("Top Up", ""), ("Settings", "")]]
        buttons.enumerated().forEach { args in
            let (columnNum, columnValues) = args
            guard let columnStackView = columns.arrangedSubviews[columnNum] as? UIStackView else {
                return
            }
            columnValues.forEach { args in
                let (text, icon) = args
                let button = DashboardActionButton.button()
                button.button.addTarget(target, action: #selector(DashboardViewController.buttonPressed), for: .touchUpInside)
                button.set(text: text, icon: icon)
                columnStackView.addArrangedSubview(button)
            }
        }
    }
    
    func runShowAnimation(_ complete: @escaping () -> ()) {
        guard let stackViews = self.columns.arrangedSubviews as? [UIStackView] else {
            return
        }
        Choreo()
            .prepareAnimations {
                self.balanceView.alpha = 0.0
                self.balanceView.transform = CGAffineTransform(translationX: 0.0, y: 10.0)
                self.hamburgerButton.alpha = 0.0
                self.shareButton.alpha = 0.0
                let animationOffset: CGFloat = 2.5
                self.hamburgerButton.transform = CGAffineTransform(translationX: -animationOffset, y: 0.0)
                self.shareButton.transform = CGAffineTransform(translationX: animationOffset, y: 0.0)
                stackViews
                    .flatMap { $0.arrangedSubviews }
                    .forEach { button in
                        button.layer.transform = CATransform3DMakeScale(0.0, 0.0, 1.0)
                }
                
            }
            .addAnimationPhase(startFraction: 0.4, durationFraction: 0.4) { (duration) in
                self.balanceView.disco
                    .duration(duration)
                    .setTiming(.predefined(.easeOut))
                    .setAlpha(to: 1.0)
                    .setTransform(to: .identity)
                    .start()
            }
            .addStaggeredAnimation(views: columns.arrangedSubviews, startFraction: 0.0, durationFraction: 1.0, delayFraction: 0.05) { (view, duration) in
                guard let stackView = view as? UIStackView else {
                    return
                }
                let columnButtons = stackView.arrangedSubviews
                columnButtons.forEach { button in
                    button.disco
                        .duration(duration)
                        .setTiming(.springBased(0.7))
                        .setTransform(to: .identity)
                        .start()
                }
            }
            .addAnimationPhase(startFraction: 0.4, durationFraction: 0.4) { duration in
                self.hamburgerButton.disco
                    .duration(duration)
                    .setAlpha(to: 1.0)
                    .setTransform(to: .identity)
                    .start()
                self.shareButton.disco
                    .duration(duration)
                    .setAlpha(to: 1.0)
                    .setTransform(to: .identity)
                    .start()
            }
            .onComplete(complete)
            .animate(totalDuration: 0.6)
    }
    
    func runHideAnimation(_ complete: @escaping () -> ()) {
        Choreo()
            .addAnimationPhase(startFraction: 0.0, durationFraction: 0.5) { duration in
                self.hamburgerButton.disco
                    .duration(duration)
                    .setTransform(to: CGAffineTransform(translationX: -2.5, y: 0.0))
                    .setAlpha(to: 0.0)
                    .start()
                
                self.shareButton.disco
                    .duration(duration)
                    .setTransform(to: CGAffineTransform(translationX: 2.5, y: 0.0))
                    .setAlpha(to: 0.0)
                    .start()
            }
            .addStaggeredAnimation(views: columns.arrangedSubviews.reversed(), startFraction: 0.0, durationFraction: 1.0, delayFraction: 0.1) { (view, duration) in
                guard let column = view as? UIStackView else {
                    return
                }
                column.arrangedSubviews.forEach { button in
                    button.disco
                        .duration(duration/2)
                        .setTiming(.springBased(0.3))
                        .setTransform(to: CGAffineTransform(scaleX: 1.25, y: 1.25))
                        .then()
                        .duration(duration/2)
                        .setTransform(to: CGAffineTransform(scaleX: 0.0, y: 0.0))
                        .start()
                }
            }
            .addAnimationPhase(startFraction: 0.5, durationFraction: 0.5) { duration in
                self.balanceView.disco
                    .setTiming(.predefined(.easeIn))
                    .duration(duration)
                    .setTransform(to: CGAffineTransform(translationX: 0.0, y: 30.0))
                    .setAlpha(to: 0.0)
                    .start()
            }
            .onComplete(complete)
            .animate(totalDuration: 0.5)
    }
    
}
