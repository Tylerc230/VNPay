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
    var onViewDidAppear: (() -> ())?
    var loginView: LoginView {
        return view as! LoginView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onViewDidAppear?()
        onViewDidAppear = nil
    }

    @IBAction func loginTapped() {
        loginDelegate?.didLogIn(loginView: self)
    }
    
    func runShowAnimation(complete: @escaping () -> ()) {
        loginView.runShowAnimation(complete: complete)
    }
    
    func runDismissAnimation(complete: @escaping () -> ()) {
        loginView.runDismissAnimation(complete: complete)
    }
    
}


