//
//  FlowCoordinator.swift
//  VNPay
//
//  Created by Tyler Casselman on 7/26/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import Foundation
class FlowCoordinator {
    let window: UIWindow
    init(withWindow window: UIWindow) {
        self.window = window
    }
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginView = storyboard.instantiateInitialViewController() as? LoginViewController else {
            fatalError()
        }
        loginView.loginDelegate = self
        window.rootViewController = loginView
        loginView.runShowAnimation()
    }
}

extension FlowCoordinator: LoginDelegate {
    func didLogIn(loginView: LoginViewController) {
        loginView.runDismissAnimation()
    }
}
