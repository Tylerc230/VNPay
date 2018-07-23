//
//  TextInputControllerPill.swift
//  VNPay
//
//  Created by Tyler Casselman on 7/12/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import Foundation
import MaterialComponents
class TextInputControllerPill: MDCTextInputControllerBase {
    override init() {
        super.init()
    }
    
    required init(textInput input: (UIView & MDCTextInput)?) {
        super.init(textInput: input)
        self.isFloatingEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isFloatingEnabled = false
    }
    //Had to move MDCTextInputControllerBase+Subclassing.h to public in podfile pod install willl probably break this
    override func updateLayout() {
        super.updateLayout()
        guard let textInput = textInput as? PillTextField else {
            return
        }
        textInput.elevation =  textInput.isEditing ? .raisedButtonPressed : .raisedButtonResting
    }
    
    override func textInsets(_ defaultInsets: UIEdgeInsets) -> UIEdgeInsets {
        var insets = defaultInsets
        insets.left = 10.0
        return insets
    }
}
