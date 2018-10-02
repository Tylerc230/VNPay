//
//  LoginDashboardAnimation.swift
//  VNPay
//
//  Created by Tyler Casselman on 8/18/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import UIKit
class LoginDashboardAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    let isPush: Bool
    init(push: Bool) {
        isPush = push
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPush {
            showPushAnimation(with: transitionContext) {
                transitionContext.completeTransition(true)
            }
        } else {
            showPopAnimation(with: transitionContext) {
                transitionContext.completeTransition(true)
            }
        }
    }
    
    func showPushAnimation(with context: UIViewControllerContextTransitioning, complete: @escaping () -> ()) {
        guard
            let loginView = context.viewController(forKey: .from) as? LoginViewController,
            let dashboard = context.viewController(forKey: .to) as? DashboardViewController
            else {
                return
        }
        let container = context.containerView
        loginView.runDismissAnimation {
            container.addSubview(dashboard.view)
            dashboard.runShowAnimation(complete)
        }
    }
    
    func showPopAnimation(with context: UIViewControllerContextTransitioning, complete: @escaping () -> ()) {
        
        guard
            let dashboard = context.viewController(forKey: .from) as? DashboardViewController,
            let loginView = context.viewController(forKey: .to) as? LoginViewController
            else {
                return
        }
        let container = context.containerView
        dashboard.runHideAnimation {
            container.addSubview(loginView.view)
            loginView.runShowAnimation(complete: complete)
        }
    }
}
