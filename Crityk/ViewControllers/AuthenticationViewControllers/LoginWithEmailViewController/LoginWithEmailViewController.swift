//
//  LoginWithEmailViewController.swift
//  Crityk
//
//  Created by Prashant Sanghavi on 14/07/16.
//  Copyright © 2016 Prashant Sanghavi. All rights reserved.
//

import UIKit

class LoginWithEmailViewController: UIViewController, UITextFieldDelegate, BSKeyboardControlsDelegate {
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var lblForgotPassword: LinkLabel!
    @IBOutlet var scrollviewBottamConstraint: NSLayoutConstraint!
    var keyboardControls: BSKeyboardControls? // Here's our property

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
        
        let fields = [txtEmail,txtPassword]
        self.keyboardControls = BSKeyboardControls(fields: fields)
        self.keyboardControls?.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginWithEmailViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginWithEmailViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil)
        
        let range = (lblForgotPassword.text! as NSString).rangeOfString(cForgotPassword)
        
        lblForgotPassword.addLink(NSURL(string: cURLForgotPassword)!, range: range, linkAttribute: [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue
        ]) { (url) -> Void in
            
            let storyboard : UIStoryboard = UIStoryboard(name: sAuthentication, bundle: nil)
            let objForgotPassword : ForgotPasswordViewController = storyboard.instantiateViewControllerWithIdentifier("ForgotPasswordVC") as! ForgotPasswordViewController
            self.presentViewController(objForgotPassword, animated: true, completion: nil)
        }
    }
    
    func isValid() -> Bool {
        self.view.endEditing(true)

        if txtEmail.text == "" {
            topAlertAction(kAlertEmailOrUserName)
            txtEmail.becomeFirstResponder()
            return false
        }
        else if stringContainsWhiteSpace(txtEmail.text!) {
            topAlertAction(kAlertEmailOrUserName)
            txtEmail.becomeFirstResponder()
            return false
        }
        else if txtPassword.text == "" {
            topAlertAction(kAlertPassword)
            txtPassword.becomeFirstResponder()
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
        self.scrollviewBottamConstraint.constant = keyboardFrame.size.height
        UIView.animateWithDuration(0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.scrollviewBottamConstraint.constant = 0
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
    
    @IBAction func btnForgotPasswordTapped(sender: AnyObject) {
        let storyboard : UIStoryboard = UIStoryboard(name: sAuthentication, bundle: nil)
        let objForgotPassword : ForgotPasswordViewController = storyboard.instantiateViewControllerWithIdentifier("ForgotPasswordVC") as! ForgotPasswordViewController
        self.presentViewController(objForgotPassword, animated: true, completion: nil)
    }

    @IBAction func btnSignInTapped(sender: AnyObject) {
        
        if isValid() {
            let dictParam = [kUsernameorEmail:(txtEmail.text)!,kPassword:(txtPassword.text)!,kDeviceToken:"123456789",kDeviceType:"2"]
            
            let objAppManager:CritykManager = CritykManager.sharedInstance
            objAppManager.serverCommunication(dictParam,requestURL: kLogin,image:nil, pCompletionBlock: { ( success : Bool!, result : AnyObject!) -> () in
                let objResult:[String:AnyObject] = result as! [String:AnyObject]
                if(success == true){
                    print(objResult)
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: kIsLogged)
                    NSUserDefaults.standardUserDefaults().setObject(objResult[kDataKey], forKey: kUserData)
                    NSUserDefaults.standardUserDefaults().synchronize()
                    UIView.setAnimationsEnabled(false)
                    self.performSegueWithIdentifier(cSegueMainStoryBoard, sender: nil)
                }
             })
        }
    }
    
    @IBAction func btnBackTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //    MARK:- Memory management

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
