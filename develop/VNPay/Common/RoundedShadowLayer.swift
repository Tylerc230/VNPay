//
//  ShapedShadowLayer.swift
//  VNPay
//
//  Created by Tyler Casselman on 9/20/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import Foundation
class RoundedShadowLayer: CAShapeLayer {
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
    
    func commonInit() {
        shadowOpacity = 0.5
        shadowColor = UIColor.gray.cgColor
    }
    
    func setActive(_ active: Bool, animated: Bool) {
        let shadowRadius: CGFloat
        let shadowOffset: CGSize
        if (active) {
            shadowOffset = CGSize(width: 0.0, height: 7.0)
            shadowRadius = 6.0
        } else {
            shadowOffset = CGSize(width: 0.0, height: 2.0)
            shadowRadius = 1.0
        }
        if (animated) {
            animate(keypath: "shadowOffset", from: self.shadowOffset, to: shadowOffset)
            animate(keypath: "shadowRadius", from: self.shadowRadius, to: shadowRadius)
        }
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
    }
    
    func animate<T>(keypath: String, from start: T, to end: T) {
        let animation = CABasicAnimation(keyPath: keypath)
        animation.fromValue = start
        animation.toValue = end
        animation.duration = 0.15
        add(animation, forKey: animation.keyPath)
    }

    override func layoutSublayers() {
        super.layoutSublayers()
        path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height/2).cgPath
        shadowPath = path
    }
}
