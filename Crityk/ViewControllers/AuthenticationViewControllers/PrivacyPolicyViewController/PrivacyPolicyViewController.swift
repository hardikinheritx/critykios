//
//  PrivacyPolicyViewController.swift
//  Crityk
//
//  Created by Prashant Sanghavi on 20/07/16.
//  Copyright © 2016 Prashant Sanghavi. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    @IBOutlet var viewWebPrivacyPolicy: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeOnce()

        // Do any additional setup after loading the view.
    }
    
    func initializeOnce() {
        let requestURL = NSURL(string:urlPrivacyPolicy)
        let request = NSURLRequest(URL: requestURL!)
        viewWebPrivacyPolicy.loadRequest(request)
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
