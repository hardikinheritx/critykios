//
//  CustomUITextField.swift
//  Crityk
//
//  Created by Prashant Sanghavi on 20/07/16.
//  Copyright © 2016 Prashant Sanghavi. All rights reserved.
//

import UIKit

class CustomUITextField: UITextField {
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == #selector(NSObject.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
