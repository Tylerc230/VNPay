//
//  DashboardActionButton.swift
//  VNPay
//
//  Created by Tyler Casselman on 8/20/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import Foundation
class DashboardActionButton: UIView {
    @IBOutlet var button: PillButton!
    @IBOutlet var label: UILabel!
    
    func set(text: String, icon: String) {
        label.text = text
        button.setTitle(icon, for: .normal)
    }
    
    class func button() -> DashboardActionButton {
        guard
            let button = UINib(nibName: "DashboardActionButton", bundle: nil)
                .instantiate(withOwner: nil, options: nil)
                .first as? DashboardActionButton
            else {
                fatalError("Nib not packaged properly")
        }
        return button
    }
}
