//
//  Button.swift
//  BridgeStone
//
//  Created by somsak.kaeworasan on 18/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

@IBDesignable class ButtonRound: UIButton {
    @IBInspectable var CornerRadius:CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = CornerRadius
        }
    }
}

@IBDesignable class placeHolderTextField: UITextField {
    @IBInspectable var placeholderColor:UIColor? = nil {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: placeholderColor!])
        }
    }
}
