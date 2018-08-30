//
//  PillButton.swift
//  VNPay
//
//  Created by Tyler Casselman on 8/20/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import Foundation
class PillButton: MDCButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    func commonInit() {
        shapeGenerator = MDCPillShapeGenerator()
        setElevation(.raisedButtonResting, for: .normal)
        setElevation(.raisedButtonPressed, for: .highlighted)
        
    }
}
