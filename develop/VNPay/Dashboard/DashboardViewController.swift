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
    
}
