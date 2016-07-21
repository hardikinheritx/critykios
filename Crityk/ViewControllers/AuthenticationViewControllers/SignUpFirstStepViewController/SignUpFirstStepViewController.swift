//
//  SignUpFirstStepViewController.swift
//  Crityk
//
//  Created by Prashant Sanghavi on 13/07/16.
//  Copyright © 2016 Prashant Sanghavi. All rights reserved.
//

import UIKit

class SignUpFirstStepViewController: UIViewController, UITextFieldDelegate, BSKeyboardControlsDelegate {
    
    @IBOutlet var viewScrollViewBottamConstraint: NSLayoutConstraint!
    
    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtConfirmPassword: UITextField!
    var keyboardControls: BSKeyboardControls? // Here's our property
    var dictParam : [String : AnyObject]!
    //    MARK:- View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeOnce()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    //    MARK:- Custom methods
    
    func initializeOnce(){
//        txtUserName.text = "prashant"
//        txtEmail.text = "prashant@inx.com"
//        txtPassword.text = "12345678"
//        txtConfirmPassword.text = "12345678"
        
        let fields = [txtUserName,txtEmail,txtPassword,txtConfirmPassword]
        self.keyboardControls = BSKeyboardControls(fields: fields)
        self.keyboardControls?.delegate = self

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SignUpFirstStepViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SignUpFirstStepViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil)
     }
    
    func isValid() -> Bool {
        
        self.view.endEditing(true)
        if txtUserName.text == "" {
            topAlertAction(kAlertName)
            txtUserName.becomeFirstResponder()
            return false
        }
        else if stringContainsWhiteSpace(txtUserName.text!) {
            topAlertAction(kAlertName)
            txtUserName.becomeFirstResponder()
            return false
        }
        else if stringContainsWhiteSpace(txtEmail.text!) {
            topAlertAction(kAlertEmail)
            txtEmail.becomeFirstResponder()
            return false
        }
        else if txtEmail.text == ""{
            topAlertAction(kAlertEmail)
            txtEmail.becomeFirstResponder()
            return false
        }
        else if !isValidEmail(txtEmail.text!) {
            topAlertAction(kAlertVaildEmail)

            txtEmail.becomeFirstResponder()
            return false
        }
        else if txtPassword.text == "" {
            topAlertAction(kAlertPassword)

            txtPassword.becomeFirstResponder()
            return false
        }
        else if txtPassword.text?.characters.count < 8 {
            topAlertAction(kAlertPasswordLength)

            txtPassword.becomeFirstResponder()
            return false
        }
        else if txtConfirmPassword.text == "" {
            topAlertAction(kAlertConfirmPassword)

            txtConfirmPassword.becomeFirstResponder()
            return false
        }
        else if txtConfirmPassword.text != txtPassword.text {
            topAlertAction(kAlertPasswordMissmatch)

            txtConfirmPassword.becomeFirstResponder()
            return false
        }
        else {
           return true
        }
    }
    
    //    MARK:- BSKeyboards delegate methods
    
    func keyboardControls(keyboardControls: BSKeyboardControls!, selectedField field: UIView!, inDirection direction: BSKeyboardControlsDirection) {
        
    }
    
    func keyboardControlsDonePressed(keyboardControls: BSKeyboardControls!) {
        keyboardControls.activeField.resignFirstResponder()
    }
    
    //    MARK:- Notification delegate methods

    func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        self.viewScrollViewBottamConstraint.constant = keyboardFrame.size.height
        UIView.animateWithDuration(0.1) { 
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.viewScrollViewBottamConstraint.constant = 0
    }
    
    //    MARK:- Textfield delegate methods
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.keyboardControls?.activeField = textField
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    //    MARK:- Action methods

    @IBAction func btnBackTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func btnNextTapped(sender: AnyObject) {
        if isValid() {
            
            self.dictParam = [kEmail:(txtEmail.text)!,kPassword:(txtPassword.text)!,kName:(txtUserName.text)!]

            self.performSegueWithIdentifier(cSegueSignUpSecondStep, sender: dictParam)
        }
    }
    
    //    MARK:- Memory management

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == cSegueSignUpSecondStep) {
            // pass data to next view
            let viewController:SignUpSecondStepViewController = segue.destinationViewController as! SignUpSecondStepViewController
             viewController.dictFirstStep = self.dictParam
        }
    }
}