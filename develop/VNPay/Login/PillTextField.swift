//
//  PillTextField.swift
//  VNPay
//
//  Created by Tyler Casselman on 7/12/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import UIKit

class PillTextField: UITextField {
    override class var layerClass: AnyClass {
        return RoundedShadowLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override var layer: RoundedShadowLayer {
        return super.layer as! RoundedShadowLayer
    }
    
    private func commonInit() {
        addTarget(self, action: #selector(startedEditing), for: .editingDidBegin)
        addTarget(self, action: #selector(stopEditing), for: .editingDidEnd)
        borderStyle = .none
        layer.fillColor = UIColor.white.cgColor
        layer.setActive(false, animated: false)
    }
    
    @objc
    private func startedEditing() {
        layer.setActive(true, animated: true)
    }
   
    @objc
    private func stopEditing() {
        layer.setActive(false, animated: true)
    }
    func set(leftIcon: String?, isRegular: Bool) {
        guard let leftIcon = leftIcon else {
            leftView = nil
            return
        }
        leftViewMode = .always
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        let fontName = isRegular ? "FontAwesome5FreeRegular" : "FontAwesome5FreeSolid"
        label.font = UIFont(name: fontName, size: 14.0)
        label.textColor = UIColor(named: "LightBlue")
        label.text = leftIcon
        label.textAlignment = .right
        leftView = label
        
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.size.width = 40
        return rect
    }
}

