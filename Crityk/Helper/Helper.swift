//
//  Helper.swift
//  Crityk
//
//  Created by Prashant Sanghavi on 13/07/16.
//  Copyright © 2016 Prashant Sanghavi. All rights reserved.
//

import Foundation
import UIKit

public func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluateWithObject(testStr)
}

public func topAlertAction(msgAlert: String) {
    
    let alert = JDropDownAlert()
    alert.alertWith(cCrityk, message: msgAlert, textColor: UIColor.whiteColor(), backgroundColor: UIColor(red: 0/255, green: 112/255, blue: 255/255, alpha: 0.9))
    //alert.alertWith("asfdsadf")
    alert.didTapBlock = {
        print("Top View Did Tapped")
    }
}

public func stringContainsWhiteSpace(objString:String) -> Bool {
    let set: NSCharacterSet = NSCharacterSet.whitespaceCharacterSet()
    if objString.stringByTrimmingCharactersInSet(set).characters.count == 0 {
        // String contains only whitespace.
        return true
    }
    else{
        return false
    }
}
