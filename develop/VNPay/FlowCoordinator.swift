//
//  FlowCoordinator.swift
//  VNPay
//
//  Created by Tyler Casselman on 7/26/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import UIKit
class FlowCoordinator: NSObject {
    let window: UIWindow
    let nav: UINavigationController
    init(withWindow window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootNav = storyboard.instantiateInitialViewController() as? UINavigationController else {
            fatalError()
        }
        nav = rootNav
        window.rootViewController = nav
        self.window = window
        super.init()
        nav.delegate = self
    }
    
    func start() {
        guard let loginView = nav.topViewController as? LoginViewController else {
            return
        }
        loginView.loginDelegate = self
        loginView.onViewDidAppear = {
            loginView.runShowAnimation()
        }
    }
}

extension FlowCoordinator: LoginDelegate {
    func didLogIn(loginView: LoginViewController) {
        guard let dashboard = loginView.storyboard?.instantiateViewController(withIdentifier: "Dashboard") else {
            return
        }
        nav.pushViewController(dashboard, animated: true)
    }
}

extension FlowCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch (fromVC, toVC) {
        case is (LoginViewController, UIViewController):
            return LoginDashboardAnimation()
        default:
            return nil
        }
    }
}
