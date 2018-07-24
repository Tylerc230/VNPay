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
    func set(leftIcon: String?, isRegular: Bool) {
        guard let leftIcon = leftIcon else {
            leadingView = nil
            return
        }
        leadingViewMode = .always
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        let fontName = isRegular ? "FontAwesome5FreeRegular" : "FontAwesome5FreeSolid"
        label.font = UIFont(name: fontName, size: 14.0)
        label.text = leftIcon
        label.textAlignment = .right
        leadingView = label
        
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
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.size.width = 40
        return rect
    }
}
