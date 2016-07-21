//
//  CameraViewController.swift
//  Crityk
//
//  Created by Prashant Sanghavi on 15/07/16.
//  Copyright © 2016 Prashant Sanghavi. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var btnlibrary: UIButton!
    @IBOutlet weak var btncamera: UIButton!
    @IBOutlet weak var btnnophoto: UIButton!
    @IBOutlet weak var imgaeView: UIImageView!
    var images = [UIImage]()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnlibrary.setBackgroundColor(TheamColor, forState: .Selected)
        btncamera.setBackgroundColor(TheamColor, forState: .Selected)
        btnnophoto.setBackgroundColor(TheamColor, forState: .Selected)
        btnlibrary.selected = true
        imagePicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnClose_Pressed(sender : UIButton)
    {
        self.tabBarController?.selectedIndex = 1
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func btn_Pressed(sender : UIButton)
    {
        if sender.tag == 1
        {
            btnlibrary.selected = true
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .PhotoLibrary
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        else
        {
            btnlibrary.selected = false
        }
        if sender.tag == 2
        {
            btncamera.selected = true
            if UIImagePickerController.isSourceTypeAvailable(.Camera)
            {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .Camera
                presentViewController(imagePicker, animated: true, completion: nil)
            }
            else
            {
                print("No Camera")
            }
        }
        else
        {
            btncamera.selected = false
        }
        if sender.tag == 3
        {
            btnnophoto.selected = true
            self.performSegueWithIdentifier("SetLocation", sender: self)
        }
        else
        {
            btnnophoto.selected = false
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgaeView.contentMode = .ScaleAspectFit
            imgaeView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
}
