//
//  SignUpSecondStepViewController.swift
//  Crityk
//
//  Created by Prashant Sanghavi on 13/07/16.
//  Copyright © 2016 Prashant Sanghavi. All rights reserved.
//

import UIKit
import AlamofireImage

class SignUpSecondStepViewController: UIViewController, UITextFieldDelegate, BSKeyboardControlsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imgProfilePicture: UIImageView!
    @IBOutlet var lblUploadPhoto: UILabel!
    @IBOutlet var txtBirthdate: CustomUITextField!
    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtPhoneNumber: CustomUITextField!
    @IBOutlet var txtZipCode: CustomUITextField!
    @IBOutlet var viewScrollViewBottamConstraint: NSLayoutConstraint!
    @IBOutlet var datePickerBirthDate: UIDatePicker!
    var keyboardControls: BSKeyboardControls? // Here's our property
    let imagePicker = UIImagePickerController()
    
    var dictFirstStep:[String : AnyObject]!
    
    
    //    MARK:- View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeOnce()

        // Do any additional setup after loading the view.
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    //    MARK:- Custom methods
    
    func initializeOnce(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SignUpSecondStepViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SignUpSecondStepViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil)
        
        txtBirthdate.inputView = self.datePickerBirthDate
        let currentDate: NSDate = NSDate()

        self.datePickerBirthDate.maximumDate = currentDate
        
        let fields = [txtUserName,txtBirthdate,txtPhoneNumber,txtZipCode]
        self.keyboardControls = BSKeyboardControls(fields: fields)
        self.keyboardControls?.delegate = self
        
        // Facebook image
        SVProgressHUD.dismiss()

//        if (self.dictFirstStep[kProfilePic] != nil) {
//            SVProgressHUD.dismiss()
//
//            let URL = NSURL(string: self.dictFirstStep[kProfilePic] as! String)!
//            imgProfilePicture.af_setImageWithURL(
//                URL,
//                placeholderImage: nil,
//                filter: nil,
//                imageTransition: .CrossDissolve(0.2)
//            )
//        }
        
        imagePicker.delegate = self
    }
    
    func setBirthDate() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = cBirthDateFormatter
        txtBirthdate.text = dateFormatter.stringFromDate(datePickerBirthDate.date)
    }
    
    func isValid() -> Bool {
        
        self.view.endEditing(true)
        if txtUserName.text == "" {
            topAlertAction(kAlertUserName)
            txtUserName.becomeFirstResponder()
            return false
        }
        else if stringContainsWhiteSpace(txtUserName.text!) {
            topAlertAction(kAlertUserName)
            txtUserName.becomeFirstResponder()
            return false
        }

        else if txtBirthdate.text == "" {
            topAlertAction(kAlertBirthdate)
            txtBirthdate.becomeFirstResponder()

            return false
        }
        else if stringContainsWhiteSpace(txtBirthdate.text!) {
            topAlertAction(kAlertBirthdate)
            txtBirthdate.becomeFirstResponder()
            
            return false
        }

        else if txtPhoneNumber.text == "" {
            topAlertAction(kAlertPhoneNumber)
            txtPhoneNumber.becomeFirstResponder()

            return false
        }
        else if txtPhoneNumber.text!.characters.count < 10 {
            topAlertAction(kAlertValidPhoneNumber)
            txtPhoneNumber.becomeFirstResponder()
            
            return false
        }

        else if stringContainsWhiteSpace(txtPhoneNumber.text!) {
            topAlertAction(kAlertPhoneNumber)
            txtPhoneNumber.becomeFirstResponder()
            
            return false
        }

        else if txtZipCode.text == "" {
            topAlertAction(kAlertZipcode)
            txtZipCode.becomeFirstResponder()
            return false
        }
        else if stringContainsWhiteSpace(txtZipCode.text!) {
            topAlertAction(kAlertZipcode)
            txtZipCode.becomeFirstResponder()
            return false
        }
        else if txtZipCode.text!.characters.count < 8 {
            topAlertAction(kAlertValidZipcode)
            txtZipCode.becomeFirstResponder()
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
        if self.keyboardControls!.activeField == txtBirthdate {
            setBirthDate()
        }
        self.keyboardControls!.activeField.resignFirstResponder()
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
    
//    class CustomTextField: UITextField {
//        override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
//            if action == #selector(self.paste) {
//                return false
//            }
//            
//            return super.canPerformAction(action, withSender: sender)
//        }
//    }

    
//    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
//        UIMenuController.sharedMenuController().menuVisible = false
//        print("performaction")
////        if action == #selector(self.paste) {
////            print("no paste")
////            return false
////        }
//        return super.canPerformAction(action, withSender:sender)
//    }
    
//    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
//        if action == #selector(self.paste) {
//            return false
//        }
//        return super.canPerformAction(action, withSender: sender)
//    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imgProfilePicture.contentMode = .ScaleToFill
            imgProfilePicture.image = pickedImage
            lblUploadPhoto.text = cUpdatePhoto
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    //    MARK:- Action methods

    @IBAction func btnPrivacyPolicyTapped(sender: AnyObject) {
        let storyboard : UIStoryboard = UIStoryboard(name: sAuthentication, bundle: nil)
        let objTermsandCondition : PrivacyPolicyViewController = storyboard.instantiateViewControllerWithIdentifier("PrivacyPolicyVC") as! PrivacyPolicyViewController
        self.presentViewController(objTermsandCondition, animated: true, completion: nil)
    }
    
    @IBAction func btnTermsandConditionsTapped(sender: AnyObject) {
        let storyboard : UIStoryboard = UIStoryboard(name: sAuthentication, bundle: nil)
        let objTermsandCondition : TermsandConditionViewController = storyboard.instantiateViewControllerWithIdentifier("TermsandConditionVC") as! TermsandConditionViewController
        self.presentViewController(objTermsandCondition, animated: true, completion: nil)
    }
    
    @IBAction func btnBackTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func btnCreateAccountTapped(sender: AnyObject) {
        if isValid() {
            var dictParam: [String: AnyObject]
            
            if (self.dictFirstStep[kFacebookId] != nil) {
                dictParam = [kEmail:dictFirstStep[kEmail] as! String,kDeviceToken:"123456789",kDeviceType:"2",kLatitude:objAppdelegate.strUserLatitude,kLongitude:objAppdelegate.strUserLongitude,kName:dictFirstStep[kName] as! String,kGender:"",kProfilePic:"",kCoverPic:"",kZipCode:(txtZipCode.text)!,kBirthDate:(txtBirthdate.text)!,kUsername:(txtUserName.text)!,kPhoneNumber:(txtPhoneNumber.text)!,kFacebookId:self.dictFirstStep[kFacebookId] as! String,kCountryCode:""]
            }
            else
            {
                dictParam = [kEmail:dictFirstStep[kEmail] as! String,kPassword:dictFirstStep[kPassword] as! String,kDeviceToken:"123456789",kDeviceType:"2",kLatitude:objAppdelegate.strUserLatitude,kLongitude:objAppdelegate.strUserLongitude,kName:dictFirstStep[kName] as! String,kGender:"",kProfilePic:"",kCoverPic:"",kZipCode:(txtZipCode.text)!,kBirthDate:(txtBirthdate.text)!,kUsername:(txtUserName.text)!,kPhoneNumber:(txtPhoneNumber.text)!,kFacebookId:"",kCountryCode:""]
            }
            
            let objAppManager:CritykManager = CritykManager.sharedInstance
            objAppManager.serverCommunication(dictParam,requestURL: kSignUp,image:imgProfilePicture.image, pCompletionBlock: { ( success : Bool!, result : AnyObject!) -> () in
                let objResult:[String:AnyObject] = result as! [String:AnyObject]
                if(success == true){
                    print(objResult)
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: kIsLogged)
                    NSUserDefaults.standardUserDefaults().setObject(objResult[kDataKey], forKey: kUserData)
                    NSUserDefaults.standardUserDefaults().synchronize()
                    UIView.setAnimationsEnabled(false)
                    self.performSegueWithIdentifier(cSegueMainStoryBoard, sender: nil)
                }
                else{
                    if objResult[kMessageKey] as! String == kAlertEmailAlreadyExists {
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                    //Email Id has been already registered. Please try with different email Id.
                }
             })
         }
    }
    
    @IBAction func imgProfilePicureTapped(sender: AnyObject) {
        
        let alert = UIAlertController(title: nil, message: cSelectProfilePicture, preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: cGallery, style: .Default, handler: { (action) -> Void in
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: cCamera, style: .Default, handler: { (action) -> Void in
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .Camera
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: cCancel, style: .Cancel, handler:nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func datePickerBirthdateTapped(sender: AnyObject) {
        setBirthDate()
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
