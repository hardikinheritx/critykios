//
//  StartUpViewController.swift
//  Crityk
//
//  Created by Prashant Sanghavi on 13/07/16.
//  Copyright © 2016 Prashant Sanghavi. All rights reserved.
//

import UIKit
 
class StartUpViewController: UIViewController {
    
    @IBOutlet var btnStartHere: UIButton!
    @IBOutlet var btnFacebook: UIButton!
    @IBOutlet var lblLogin: LinkLabel!
    var dictParam : [String : AnyObject]!

    //    MARK:- View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializeOnce()
    }
    
    //    MARK:- Custom methods
    
    func initializeOnce(){
        
        if NSUserDefaults.standardUserDefaults().boolForKey(kIsLogged) == true {
            UIView.setAnimationsEnabled(false)
            self.performSegueWithIdentifier(cSegueMainStoryBoard, sender: nil)
         }

        btnStartHere.exclusiveTouch = true
        btnFacebook.exclusiveTouch = true
        
        let range = (lblLogin.text! as NSString).rangeOfString(cLogin)
        
        lblLogin.addLink(NSURL(string: cURLLogin)!, range: range, linkAttribute: [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue
        ]) { (url) -> Void in
            self.performSegueWithIdentifier(cSegueLogin, sender: nil)
        }
    }
    
    //    MARK:- Action methods
    @IBAction func btnLoginTapped(sender: AnyObject) {
        self.performSegueWithIdentifier(cSegueLogin, sender: nil)
    }
    
    @IBAction func btnStartHereTapped(sender: AnyObject) {
        self.performSegueWithIdentifier(cSegueSignUpFirstStep, sender: nil)
    }
    
    @IBAction func btnFacebookTapped(sender: AnyObject) {
        let login: FBSDKLoginManager = FBSDKLoginManager()
        login.logOut()
        login.logInWithReadPermissions(["public_profile","email"], fromViewController: self, handler: {(result: FBSDKLoginManagerLoginResult!, error: NSError!) -> Void in
            if error != nil
            {
                print(error)
                print("Process error");
            }
            else if result.isCancelled
            {
                print("Cancelled")
            }
            else
            {
                print("Logged in")
                SVProgressHUD.show()
                self.fetchDataFromFacebook()
            }
        })
    }
    
    func fetchDataFromFacebook()
    {
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, link, email, gender,picture.type(large)"]).startWithCompletionHandler({(connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
                
                if error == nil
                {
                    print("Facebook data = %@", result)
                    
//                    let   dictParams :[String : AnyObject] = [kEmail:result["email"] as! String,kDeviceType:kDeviceTypeiOS,kDeviceToken:"12345",kLoginType:kLoginSocial,kFacebookID:result["id"] as! String]
//                    
//                    self.callWSLogin(dictParams)
                    self.dictParam = [kEmail:result["email"] as! String,kFacebookId:result["id"] as! String, kName:result["name"] as! String,kProfilePic:result["picture"]!!["data"]!!["url"] as! String]

                    self.performSegueWithIdentifier(cSegueSignUpSecondStep, sender: nil)
                }
                else
                {
                    NSLog("Error %@", error.description)
                }
            })
        }
        else
        {
            print("Access token is not generated")
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
