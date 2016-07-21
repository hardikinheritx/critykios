//
//  SelectLocationViewController.swift
//  Crityk
//
//  Created by Niketan on 7/21/16.
//  Copyright © 2016 Prashant Sanghavi. All rights reserved.
//

import UIKit

class SelectLocationViewController: UIViewController, UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var txtviewsearch : UITextField!
    var arrMainContacts : NSMutableArray?
    
    // MARK: - UIButton Action
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.tableFooterView = UIView()
        txtviewsearch.addTarget(self, action: #selector(SelectLocationViewController.textFieldTextDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        txtviewsearch.attributedPlaceholder = NSAttributedString(string:"Find a location..",attributes:[NSForegroundColorAttributeName: TheamColor])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnback(sender: UIButton){
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - UITextField delegate
    
    func textFieldTextDidChange(textField: UITextField) -> Bool {
        if !(textField.text?.isEmpty)!
        {
            print("",textField.text)
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.dismissKeyboard()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.dismissKeyboard()
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //MARK: - UITableView Delegates
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let bgColorView = UIView()
        let lbltitle = Cell.viewWithTag(2) as! UILabel
        let lblsubtitle = Cell.viewWithTag(3) as! UILabel
        lbltitle.highlightedTextColor = UIColor.whiteColor();
        lblsubtitle.highlightedTextColor = UIColor.whiteColor()
        bgColorView.backgroundColor = TheamColor
        Cell.selectedBackgroundView = bgColorView
        
        return Cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
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
