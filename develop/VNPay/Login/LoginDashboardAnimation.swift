//
//  LoginDashboardAnimation.swift
//  VNPay
//
//  Created by Tyler Casselman on 8/18/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import Foundation
class LoginDashboardAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let loginView = transitionContext.viewController(forKey: .from) as? LoginViewController,
            let dashboard = transitionContext.viewController(forKey: .to)
            else {
                return
        }
        let container = transitionContext.containerView
        loginView.runDismissAnimation {
            transitionContext.completeTransition(true)
            container.addSubview(dashboard.view)
        }
    }
}
