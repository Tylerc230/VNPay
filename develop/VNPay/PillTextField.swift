//
//  PillTextField.swift
//  VNPay
//
//  Created by Tyler Casselman on 7/12/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import Foundation
import MaterialComponents
class PillTextField: MDCTextField {
    override class var layerClass: AnyClass {
        return MDCShapedShadowLayer.self
    }
    
    var shadowLayer: MDCShapedShadowLayer {
        return layer as! MDCShapedShadowLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        borderPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.size.height/2)
        borderView?.borderFillColor = .white
        shadowLayer.shadowPath = borderPath?.cgPath
        shadowLayer.elevation = .raisedButtonResting
        self.underline?.lineHeight = 0.0
    }
}
