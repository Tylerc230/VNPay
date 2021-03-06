//
//  ShapedShadowLayer.swift
//  VNPay
//
//  Created by Tyler Casselman on 9/20/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import UIKit
class RoundedShadowLayer: CAShapeLayer {
    let animatableKeyPaths = ["path": \CAShapeLayer.path, "shadowPath": \.shadowPath]
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        commonInit()
    }
    
    override var bounds: CGRect {
        didSet {
            path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height/2).cgPath
            shadowPath = path
        }
    }
    
    override func action(forKey event: String) -> CAAction? {
        guard let keyPath = animatableKeyPaths[event] else {
            return super.action(forKey: event)
        }
        guard let key = animationKeys()?.first, let modelAnimation = super.animation(forKey: key) else {
            return super.action(forKey: event)
        }
        
        let animation = CABasicAnimation(keyPath: event)
        animation.duration = modelAnimation.duration
        animation.timingFunction = modelAnimation.timingFunction
        animation.fromValue = self[keyPath: keyPath]
        return animation
    }
    
    func commonInit() {
        shadowOpacity = 0.5
        shadowColor = UIColor.gray.cgColor
        needsDisplayOnBoundsChange = true
        fillColor = UIColor.white.cgColor
        setActive(false, animated: false)
    }
    
    func setActive(_ active: Bool, animated: Bool) {
        let shadowRadius: CGFloat
        let shadowOffset: CGSize
        let zHeight: CGFloat
        if active {
            shadowOffset = CGSize(width: 0.0, height: 7.0)
            shadowRadius = 10.0
            zHeight = 40.0
        } else {
            shadowOffset = CGSize(width: 0.0, height: 7.0)
            shadowRadius = 7.0
            zHeight = 0.0
        }
        let transform = perspectiveTransform(for: zHeight)
        if animated {
            animate(keypath: "transform", from: self.transform, to: transform)
            animate(keypath: "shadowOffset", from: self.shadowOffset, to: shadowOffset)
            animate(keypath: "shadowRadius", from: self.shadowRadius, to: shadowRadius)
        }
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
        self.transform = transform

    }
    
    func perspectiveTransform(for zHeight: CGFloat) -> CATransform3D {
        var t = CATransform3DIdentity
        t.m34 = 1.0/(-500.0)
        t = CATransform3DTranslate(t, 0.0, 0.0, zHeight)
        return t
    }
    
    func animate<T>(keypath: String, from start: T, to end: T) {
        let animation = CABasicAnimation(keyPath: keypath)
        animation.fromValue = start
        animation.toValue = end
        animation.duration = 0.15
        add(animation, forKey: animation.keyPath)
    }

}
