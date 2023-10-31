//
//  RoundButton.swift
//  Calculator
//
//  Created by YURI KIM on 2023/10/31.
//

import UIKit

//@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }

}
