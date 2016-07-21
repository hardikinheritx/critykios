//
//  SelectOrderViewController.swift
//  Crityk
//
//  Created by Niketan on 7/21/16.
//  Copyright © 2016 Prashant Sanghavi. All rights reserved.
//

import UIKit

class SelectOrderViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var txtviewsearch : UITextField!
    var collectionviewselection: Int = 0
    var Items : NSMutableArray = ["All items", "Dinner", "Lunch", "Brunch"]
    
    //MARK: - Self Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        txtviewsearch.addTarget(self, action: #selector(SelectLocationViewController.textFieldTextDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        tableview.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIButton Action
    
    @IBAction func btnback(sender: UIButton){
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    ////MARK: - UICollectionView Delegates
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        let lbl = Cell.viewWithTag(1) as! UILabel
        let viewselected = Cell.viewWithTag(2)
        
        if collectionviewselection == indexPath.row
        {
            viewselected?.hidden = false;
            lbl.textColor = TheamColor
        }
        else
        {
            viewselected?.hidden = true;
            lbl.textColor = UIColor.blackColor()
        }
        
        lbl.text = self.Items[indexPath.row] as? String
        
        
        return Cell;
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionviewselection = indexPath.row
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
        collectionView.reloadData()
    }
    
    //MARK: - UITableView Delegates
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
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
        return Cell;
        
    }
    
    //    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
    //        let cell  = tableView.cellForRowAtIndexPath(indexPath)
    //        cell!.contentView.backgroundColor = .redColor()
    //    }
    //
    //    func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
    //        let cell  = tableView.cellForRowAtIndexPath(indexPath)
    //        cell!.contentView.backgroundColor = .clearColor()
    //    }
    
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
    
    //    func keyboardWillShow(notification: NSNotification) {
    //        let userInfo:NSDictionary = notification.userInfo!
    //        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
    //        let keyboardRectangle = keyboardFrame.CGRectValue()
    //
    //        UIView.animateWithDuration(0.3, animations: { () -> Void in
    //            self.tblContactBottomSpaceConstraint.constant =  keyboardRectangle.size.height
    //            self.view.layoutIfNeeded()
    //        })
    //    }
    //
    //    func keyboardWillHide(notification: NSNotification) {
    //        UIView.animateWithDuration(0.3, animations: { () -> Void in
    //            self.tblContactBottomSpaceConstraint.constant = 0
    //            self.view.layoutIfNeeded()
    //        })
    //    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
