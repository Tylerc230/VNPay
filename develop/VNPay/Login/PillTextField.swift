//
//  PillTextField.swift
//  VNPay
//
//  Created by Tyler Casselman on 7/12/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import UIKit

class PillTextField: UITextField {
    var maskSublayer: CALayer?
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
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.maskSublayer?.frame = layer.bounds
    }
    
    private func commonInit() {
        addTarget(self, action: #selector(startedEditing), for: .editingDidBegin)
        addTarget(self, action: #selector(stopEditing), for: .editingDidEnd)
        borderStyle = .none
    }
    
    @objc
    private func startedEditing() {
        layer.setActive(true, animated: true)
        textColor = UIColor(named: "DarkBlue")
    }
   
    @objc
    private func stopEditing() {
        layer.setActive(false, animated: true)
        textColor = UIColor(named: "ValidGreen")
    }
    
    var showContents: Bool = true {
        didSet {
            if showContents  {
                maskSublayer?.removeFromSuperlayer()
                maskSublayer = nil
            } else {
                guard maskSublayer == nil else {
                    return
                }
                let layer = CALayer(layer: self.layer)
                layer.backgroundColor = UIColor.white.cgColor
                layer.frame = layer.bounds
                layer.cornerRadius = frame.height/2
                layer.masksToBounds = true
                layer.zPosition = 1.0
                self.layer.addSublayer(layer)
                maskSublayer = layer
            }
        }
    }
    
    func set(leftIcon: String?, isRegular: Bool) {
        guard let leftIcon = leftIcon else {
            leftView = nil
            return
        }
        leftViewMode = .always
        leftView = label(for: leftIcon, isRegular: isRegular, color: UIColor(named: "LightBlue")!)
        
    }
    
    func set(rightIcon: String?, isRegular: Bool) {
        guard let rightIcon = rightIcon else {
            rightView = nil
            return
        }
        rightViewMode = .always
        rightView = label(for: rightIcon, isRegular: isRegular, color: .lightGray)
    }
    
    func label(for icon:String, isRegular: Bool, color: UIColor) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40.0, height: 20))
        let fontName = isRegular ? "FontAwesome5FreeRegular" : "FontAwesome5FreeSolid"
        label.font = UIFont(name: fontName, size: 14.0)
        label.textColor = color
        label.text = icon
        label.textAlignment = .center
        return label
    }
}


