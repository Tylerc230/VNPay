//
//  ViewController.swift
//  VNPay
//
//  Created by Tyler Casselman on 7/10/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import UIKit
protocol LoginDelegate: class {
    func didLogIn(loginView: LoginViewController);
}

class LoginViewController: UIViewController {
    weak var loginDelegate: LoginDelegate?
    var loginView: LoginView {
        return view as! LoginView
    }

    @IBAction func loginTapped() {
        loginDelegate?.didLogIn(loginView: self)
    }
    
    func runShowAnimation() {
        loginView.runShowAnimation()
    }
    
    func runDismissAnimation() {
        loginView.runDismissAnimation()
    }
    
}


