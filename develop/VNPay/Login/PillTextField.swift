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
    let pillShapeGenerator = MDCPillShapeGenerator()
    private let hideContentView = MDCTextInputBorderView(frame: .zero)
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
    
    var showContents: Bool = true {
        didSet {
            if showContents {
                hideContentView.removeFromSuperview()
            } else {
                hideContentView.layer.zPosition = 1.0
                hideContentView.frame = bounds
                addSubview(hideContentView)
            }
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
        label.textColor = UIColor(named: "LightBlue")
        label.text = leftIcon
        label.textAlignment = .right
        leadingView = label
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        shadowLayer.shapeGenerator = pillShapeGenerator
        if let borderView = borderView {
            setup(borderView: borderView)
        }
        setup(borderView: hideContentView)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.size.width = 40
        return rect
    }
    
    func setup(borderView: MDCTextInputBorderView) {
        borderView.borderFillColor = .white
        if let path = pillShapeGenerator.path(for: bounds.size)?.takeRetainedValue() {
            borderView.borderPath = UIBezierPath(cgPath: path)
        }
    }
}

