//
//  DashboardViewController.swift
//  VNPay
//
//  Created by Tyler Casselman on 8/20/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import Foundation
class DashboardViewController: UIViewController {
    @IBOutlet var columns: UIStackView!
    func layoutButtons() {
        let buttons = [[("My Profile"), ("Transaction Report"), ("Other")],
            [("Fund Transfer"), ("Register"), ("Search")],
            [("Payment"), ("Top Up"), ("Settings")]]
        buttons.enumerated().forEach { args in
            let (columnNum, columnValues) = args
            guard let columnStackView = columns.arrangedSubviews[columnNum] as? UIStackView else {
                return
            }
            columnValues.forEach { buttonName in
                let button = DashboardActionButton.button()
                button.set(text: buttonName, icon: "")
                columnStackView.addArrangedSubview(button)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutButtons()
    }
    
    func runShowAnimation(_ complete: @escaping () -> ()) {
        guard let stackViews = self.columns.arrangedSubviews as? [UIStackView] else {
            return
        }
        guard let buttonSize = stackViews.first?.arrangedSubviews.first?.frame.size else {
            return
        }
        Choreo()
            .prepareAnimations {
                stackViews
                    .flatMap { $0.arrangedSubviews }
                    .forEach { button in
                        button.layer.transform = CATransform3DMakeScale(0.0, 0.0, 1.0)
                    }
                
            }
            .addStaggeredAnimation(views: columns.arrangedSubviews, startFraction: 0.0, durationFraction: 1.0, delayFraction: 0.05) { (view, duration) in
                guard let stackView = view as? UIStackView else {
                    return
                }
                let columnButtons = stackView.arrangedSubviews
                columnButtons.forEach { button in
                    button
                        .easing(.elasticOut)
                        .scaleXY(0.0, 0.0)
                        .reverses()
                        .duration(duration)
                        .animate()
//                    UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.0, options: [], animations: {
//                        button.transform = .identity
//                    }, completion: nil)
                }
            }
            .onComplete(complete)
            .animate(totalDuration: 0.6)
    }
    
}
