//
//  CritykManager.swift
//  Crityk
//
//  Created by Prashant Sanghavi on 18/07/16.
//  Copyright © 2016 Prashant Sanghavi. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
import Alamofire

typealias CritykAppCompletionBlock = (Bool,AnyObject!) -> ()
var managerAlamofire : Alamofire.Manager!

class CritykManager: NSObject {
    
    var dictUserProperties:[String:AnyObject]!
    
    class var sharedInstance: CritykManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: CritykManager? = nil
        }
        dispatch_once(&Static.onceToken)
        {
            let objSharedInstance = CritykManager()
            Static.instance = objSharedInstance
        }
        return Static.instance!
    }
    
    func isConnectedToNetwork() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func serverCommunication(dictParam:[String:AnyObject]?,requestURL:String,image: UIImage?,pCompletionBlock:CritykAppCompletionBlock) {
        SVProgressHUD.show()

        if isConnectedToNetwork() == true
        {
            let url = kBaseUrl + requestURL
            
            print(dictParam)
            
            if image != nil {
                
                Alamofire.upload(.POST, url, multipartFormData: {
                    multipartFormData in
                    
                    if let _image = image {
                        if let imageData = UIImageJPEGRepresentation(_image, 0.5) {
                            multipartFormData.appendBodyPart(data: imageData, name: kProfilePic, fileName: "file.png", mimeType: "image/png")
                        }
                    }
                    
                    for (key, value) in dictParam! {
                        multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
                    }
                    
                    }, encodingCompletion: {
                        encodingResult in
                        
                        switch encodingResult {
                        case .Success(let upload, _, _):
                            upload.responseJSON { (response) -> Void in
                                do {
                                    let objJson:[String:AnyObject] = try NSJSONSerialization.JSONObjectWithData(response.data!, options: []) as! [String : AnyObject]
                                    print(objJson)
                                    SVProgressHUD.dismiss()
                                    
                                    topAlertAction(objJson[kMessageKey] as! String)
                                    
                                    guard objJson[kError] != nil
                                        else{
                                            return
                                    }
                                    switch (objJson[kError] as! NSString).doubleValue
                                    {
                                    case -1:
                                        //self.showAlert(ALERTINVALIDUSER, pobjView: appDelegateWindow!)
                                        break
                                        
                                    case -2:
                                        // self.showAlert(ALERTAUTHTOKENNOTVALID, pobjView: appDelegateWindow!)
                                        break
                                        
                                    case 1:
                                        pCompletionBlock(false,objJson)
                                        break
                                        
                                    case 0:
                                        pCompletionBlock(true,objJson)
                                        break
                                        
                                    case 5:
                                        pCompletionBlock(false,objJson)
                                        break
                                        
                                    default:
                                        break;
                                    }
                                } catch let error as NSError {
                                    SVProgressHUD.dismiss()
                                    topAlertAction(error.localizedDescription)
                                }
                            }
                        case .Failure(let encodingError):
                            print(encodingError)
                    }
                })
            }
            else{
                
                Alamofire.request(.POST, url , parameters:dictParam , encoding: .JSON, headers: nil).responseString(encoding: NSUTF8StringEncoding) { (response) -> Void in
                    
                    do {
                        let objJson:[String:AnyObject] = try NSJSONSerialization.JSONObjectWithData(response.data!, options: []) as! [String : AnyObject]
                        print(objJson)
                        SVProgressHUD.dismiss()
                        topAlertAction(objJson[kMessageKey] as! String)

                        guard objJson[kError] != nil
                            else{
                                return
                        }
                        switch (objJson[kError] as! NSString).doubleValue
                        {
                        case -1:
                            //self.showAlert(ALERTINVALIDUSER, pobjView: appDelegateWindow!)
                            break;
                            
                        case -2:
                            // self.showAlert(ALERTAUTHTOKENNOTVALID, pobjView: appDelegateWindow!)
                            break;
                            
                        case 1:
                            pCompletionBlock(false,objJson)
                            break;
                            
                        case 0:
                            pCompletionBlock(true,objJson)
                            break;
                            
                        default:
                            break;
                        }
                    } catch let error as NSError {
                        SVProgressHUD.dismiss()
                        topAlertAction(error.localizedDescription)
                    }
                }
            }
        }
        else{
            SVProgressHUD.dismiss()
            topAlertAction(kAlertInternet)
        }
    }
}