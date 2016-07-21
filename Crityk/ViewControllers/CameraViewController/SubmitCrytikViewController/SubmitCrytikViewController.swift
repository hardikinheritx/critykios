//
//  SubmitCrytikViewController.swift
//  Crityk
//
//  Created by Niketan on 7/21/16.
//  Copyright © 2016 Prashant Sanghavi. All rights reserved.
//

import UIKit
import RKTagsView
import EDStarRating

class SubmitCrytikViewController: UIViewController, UITextFieldDelegate,RKTagsViewDelegate,EDStarRatingProtocol,UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var viewScrollViewBottamConstraint: NSLayoutConstraint!
    @IBOutlet weak var tagsViewHashtag: RKTagsView!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var rateView: EDStarRating!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var ItemsType : NSMutableArray = ["Vegitarian", "Vegan", "Raw", "Lowcarb", "Nutfree", "Paleo", "Pescatarian"]
    var ItemsImageNormal : NSMutableArray = ["vegitarian_food", "vegan_food", "row_food", "lowcarb_food", "nutfree_food", "paleo_food", "pescatarian_food"]
    var ItemsImageSelected : NSMutableArray = ["vegitarian_food_white", "vegan_food_white", "row_food_white", "lowcarb_food_white", "nutfree_food_white", "paleo_food_white", "pescatarian_food_white"]
    var arrSelected = [String]()
    
    //MARK: - Self Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tagsViewHashtag.textField.returnKeyType = .Done
        self.tagsViewHashtag.textField.delegate = self
        self.tagsViewHashtag.delegate = self
        self.tagsViewHashtag.textField.placeholder = "(ex. #superspicy)"
        self.tagsViewHashtag.textField.keyboardAppearance = .Dark
        self.rateView.delegate = self
        self.rateView.maxRating = 5
        self.rateView.displayMode = 1
        self.rateView.editable = true
        self.rateView.starImage = UIImage.init(named: "star")
        self.rateView.starHighlightedImage = UIImage.init(named: "starfill")
        
        let center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: #selector(SubmitCrytikViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(SubmitCrytikViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITextField Delegates
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - CollectionView Delegates
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        let btn = Cell.viewWithTag(1) as! UIButton
        btn.setTitle(ItemsType[indexPath.row] as? String, forState: .Normal)
        btn.setImage(UIImage.init(named: (ItemsImageNormal[indexPath.row] as? String)!), forState: .Normal)
        btn.setImage(UIImage.init(named: (ItemsImageSelected[indexPath.row] as? String)!), forState: .Selected)
        btn.setBackgroundColor(TheamColor, forState: .Selected)
        if arrSelected.contains(btn.currentTitle!)
        {
            btn.selected = true
        }
        else
        {
            btn.selected = false
        }
        return Cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let str:String = "\((ItemsType[indexPath.row] as? String)!),"
        let calCulateSizze: CGSize = str.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(14)])
        //        NSLog("%f     %f",calCulateSizze.height, calCulateSizze.width)
        return CGSizeMake(calCulateSizze.width+60,35)
    }
    
    //MARK: - UIButton Action
    
    @IBAction func btnCollectionviewSelected(sender: UIButton)
    {
        if sender.selected
        {
            for (index, value) in arrSelected.enumerate() {
                
                if sender.currentTitle == value
                {
                    arrSelected.removeAtIndex(index)
                }
            }
        }
        else
        {
            arrSelected.append(sender.currentTitle!)
            
        }
        sender.selected = !sender.selected
    }
    
    @IBAction func btnFacebookShare(sender: UIButton) {
        sender.selected = !sender.selected
    }
    
    @IBAction func btnback(sender: UIButton){
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
//    func keyboardWillShow(notification: NSNotification) {
//        
//        var userInfo: [NSObject : AnyObject] = notification.userInfo!
//        let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
//        var viewFrame: CGRect = CGRectMake(0, 64, scrollView.frame.size.width, self.view.frame.size.height - 60)
//        viewFrame.size.height -= keyboardSize.height + 20
//        UIView.beginAnimations(nil, context: nil)
//        UIView.setAnimationBeginsFromCurrentState(true)
//        scrollView.frame = viewFrame
//        UIView.commitAnimations()
//        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 407 + keyboardSize.height)
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
//        
//        var userInfo: [NSObject : AnyObject] = notification.userInfo!
//        let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
//        var viewFrame: CGRect = CGRectMake(0, 64, scrollView.frame.size.width, self.view.frame.size.height - 60)
//        viewFrame.size.height -= keyboardSize.height + 20
//        UIView.beginAnimations(nil, context: nil)
//        UIView.setAnimationBeginsFromCurrentState(true)
//        scrollView.frame = viewFrame
//        UIView.commitAnimations()
//        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 607)
//        
//    }
    
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

    
    //MARK: - Ratings Delegates
    
    func starsSelectionChanged(control: EDStarRating!, rating: Float) {
        print("Rate:",rating)
    }
    
    func tagsView(tagsView: RKTagsView, shouldAddTagWithText text: String) -> Bool {
        
        var count : Int = 0
        for character in text.characters {
            if character == "#"
            {
                count += 1
            }
        }
        if text[0] == "#" && count == 1 && text.characters.count > 1
        {
            return true
        }
        return false
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
