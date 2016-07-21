//
//  TabbarController.swift
//  Crityk
//
//  Created by Prashant Sanghavi on 15/07/16.
//  Copyright © 2016 Prashant Sanghavi. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.addCenterButtonWithImage(UIImage(named: "img_create_crityk")!, highlightImage: UIImage(named: "img_create_crityk")!, target: self, action: #selector(self.buttonPressed))
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        UIView.setAnimationsEnabled(true)

        let storyboard = UIStoryboard(name: storyBoardHome, bundle: NSBundle.mainBundle())
        let viewController = storyboard.instantiateInitialViewController()
        
        if let viewController = viewController {
            let selectedVC: UINavigationController = self.viewControllers![0] as! UINavigationController
            selectedVC.pushViewController(viewController, animated: true)
        }
    }
    
    func addCenterButtonWithImage(buttonImage: UIImage, highlightImage: UIImage, target: AnyObject, action: Selector){
        
        let button: UIButton = UIButton(type: .Custom)
        button.autoresizingMask = [.FlexibleRightMargin, .FlexibleLeftMargin, .FlexibleBottomMargin, .FlexibleTopMargin]
        button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width+10, buttonImage.size.height+10)
        button.setBackgroundImage(buttonImage, forState: .Normal)
        button.setBackgroundImage(highlightImage, forState: .Highlighted)
        let heightDifference: CGFloat = buttonImage.size.height - self.tabBar.frame.size.height
        if heightDifference < 0 {
            button.center = self.tabBar.center
        }
        else {
            var center: CGPoint = self.tabBar.center
            center.y = center.y - heightDifference / 2.0
            button.center = center
        }
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        self.view!.addSubview(button)
    }
    
    func buttonPressed(sender: AnyObject) {
        self.selectedIndex = 2
        let storyboard = UIStoryboard(name: storyBoardCamera, bundle: NSBundle.mainBundle())
        let objCameraVC = storyboard.instantiateInitialViewController()
        
        if let viewController = objCameraVC {
            let selectedVC: UINavigationController = self.viewControllers![2] as! UINavigationController
            selectedVC.presentViewController(viewController, animated: true, completion: nil)
        }
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        if item.tag == 1001 {
            let storyboard = UIStoryboard(name: storyBoardHome, bundle: NSBundle.mainBundle())
            let objHomeVC = storyboard.instantiateInitialViewController()
            
            if let viewController = objHomeVC {
                let selectedVC: UINavigationController = self.viewControllers![0] as! UINavigationController
                selectedVC.pushViewController(viewController, animated: true)
            }
        }
        else if item.tag == 1002 {
            let storyboard = UIStoryboard(name: storyBoardDiscovery, bundle: NSBundle.mainBundle())
            let objDiscoveryVC = storyboard.instantiateInitialViewController()
            
            if let viewController = objDiscoveryVC {
                let selectedVC: UINavigationController = self.viewControllers![1] as! UINavigationController
                selectedVC.pushViewController(viewController, animated: true)
            }
        }
        else if item.tag == 1003 {
            let storyboard = UIStoryboard(name: storyBoardCamera, bundle: NSBundle.mainBundle())
            let objCameraVC = storyboard.instantiateInitialViewController()
            
            if let viewController = objCameraVC {
                let selectedVC: UINavigationController = self.viewControllers![2] as! UINavigationController
                selectedVC.presentViewController(viewController, animated: true, completion: nil)
            }
        }
        else if item.tag == 1004 {
            let storyboard = UIStoryboard(name: storyBoardSearchLocation, bundle: NSBundle.mainBundle())
            let objExploreVC = storyboard.instantiateInitialViewController()
            
            if let viewController = objExploreVC {
                let selectedVC: UINavigationController = self.viewControllers![3] as! UINavigationController
                selectedVC.pushViewController(viewController, animated: true)
            }
        }
        else if item.tag == 1005 {
            let storyboard = UIStoryboard(name: storyBoardProfile, bundle: NSBundle.mainBundle())
            let objProfileVC = storyboard.instantiateInitialViewController()
            
            if let viewController = objProfileVC {
                let selectedVC: UINavigationController = self.viewControllers![4] as! UINavigationController
                selectedVC.pushViewController(viewController, animated: true)
            }
        }
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
