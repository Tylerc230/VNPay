//
//  PillButton.swift
//  VNPay
//
//  Created by Tyler Casselman on 8/20/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import UIKit

class PillButton: UIButton {
    public override class var layerClass: Swift.AnyClass {
        return RoundedShadowLayer.self
    }
    
    override var layer: RoundedShadowLayer {
        return super.layer as! RoundedShadowLayer
    }
    
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
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        backgroundColor = .clear
        layer.fillColor = UIColor.white.cgColor
        layer.setActive(false, animated: false)
    }
    
    @objc
    func touchDown() {
        layer.setActive(true, animated: true)
    }
    
    @objc
    func touchUp() {
        layer.setActive(false, animated: true)
    }
}
