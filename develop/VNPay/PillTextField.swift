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

    var elevation: ShadowElevation {
        set {
            shadowLayer.elevation = newValue
        }

        get {
            return shadowLayer.elevation
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let pillShapeGenerator = MDCPillShapeGenerator()
        borderView?.borderFillColor = .white
        shadowLayer.shapeGenerator = pillShapeGenerator
        if let path = pillShapeGenerator.path(for: bounds.size)?.takeRetainedValue() {
            borderPath = UIBezierPath(cgPath: path)
        }
    }
}
