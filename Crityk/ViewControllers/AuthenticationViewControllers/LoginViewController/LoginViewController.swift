//
//  LoginViewController.swift
//  Crityk
//
//  Created by Prashant Sanghavi on 13/07/16.
//  Copyright © 2016 Prashant Sanghavi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var btnFacebookLogin: UIButton!
    @IBOutlet var btnLogin: UIButton!
    
    //    MARK:- View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializeOnce()
    }
    
    //    MARK:- Custom methods
    
    func initializeOnce(){
        btnFacebookLogin.exclusiveTouch = true
        btnLogin.exclusiveTouch = true
    }
    
    //    MARK:- Action methods

    @IBAction func btnBackTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func btnFacebookLoginTapped(sender: AnyObject) {
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
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, link, email, gender, picture.type(large)"]).startWithCompletionHandler({(connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
                
                if error == nil
                {
                    print("Facebook data = %@", result)
                    
                    //                    let   dictParams :[String : AnyObject] = [kEmail:result["email"] as! String,kDeviceType:kDeviceTypeiOS,kDeviceToken:"12345",kLoginType:kLoginSocial,kFacebookID:result["id"] as! String]
                    //
                    //                    self.callWSLogin(dictParams)
                    
                    let dictParam = [kUsernameorEmail:result["email"] as! String,kFacebookId:result["id"] as! String,kDeviceToken:"123456789",kDeviceType:"2"]
                    
                    let objAppManager:CritykManager = CritykManager.sharedInstance
                    objAppManager.serverCommunication(dictParam,requestURL: kLogin,image:nil, pCompletionBlock: { ( success : Bool!, result : AnyObject!) -> () in
                        let objResult:[String:AnyObject] = result as! [String:AnyObject]
                        if(success == true){
                            print(objResult)
                            NSUserDefaults.standardUserDefaults().setBool(true, forKey: kIsLogged)
                            NSUserDefaults.standardUserDefaults().setObject(objResult[kDataKey], forKey: kUserData)
                            NSUserDefaults.standardUserDefaults().synchronize()
                            self.performSegueWithIdentifier(cSegueMainStoryBoard, sender: nil)
                        }
                    })
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
    
    @IBAction func btnLoginTapped(sender: AnyObject) {
        self.performSegueWithIdentifier(cSegueLoginWithEmail, sender: nil)
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
