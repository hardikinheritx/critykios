//
//  ForgotPasswordViewController.swift
//  Crityk
//
//  Created by Prashant Sanghavi on 15/07/16.
//  Copyright © 2016 Prashant Sanghavi. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func isValid() -> Bool {
        if txtEmail.text == "" {
            topAlertAction(kAlertEmail)
            return false
        }
        else if stringContainsWhiteSpace(txtEmail.text!) {
            topAlertAction(kAlertEmail)
            txtEmail.becomeFirstResponder()
            return false
        }
        else if !isValidEmail(txtEmail.text!) {
            topAlertAction(kAlertVaildEmail)
            return false
        }
        else{
            return true
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func btnRecoverPassword(sender: AnyObject) {
        if isValid() {
            
            let dictParam = [kEmail:(txtEmail.text)!]
            
            let objAppManager:CritykManager = CritykManager.sharedInstance
            objAppManager.serverCommunication(dictParam,requestURL: kforgotpassword,image:nil, pCompletionBlock: { ( success : Bool!, result : AnyObject!) -> () in
                let objResult:[String:AnyObject] = result as! [String:AnyObject]
                if(success == true){
                    print(objResult)
                     self.dismissViewControllerAnimated(true, completion: nil)
                }
                else{
                    //                    Helper.showAlert(objResult[kMessageKey] as! String, pobjView: self.view)
                }
            })
        }
    }
    
    @IBAction func btnBackTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
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
