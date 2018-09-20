//
//  ShapedShadowLayer.swift
//  VNPay
//
//  Created by Tyler Casselman on 9/20/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import Foundation
class RoundedShadowLayer: CAShapeLayer {
    /*
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
 */
    
    override func layoutSublayers() {
        super.layoutSublayers()
        path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height/2).cgPath
        shadowPath = path
    }
}
