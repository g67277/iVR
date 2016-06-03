//
//  Validation.swift
//  Saloof
//
//  Created by Nazir Shuqair on 8/2/15.
//  Copyright (c) 2015 SNASTek. All rights reserved.
//

import Foundation
import UIKit

public class Validation {
    
    //Validates entery lenght based on passed check integer
    func validateInput(input: String, check: Int, title: String, message: String) -> Bool{
        
        if input.characters.count > check {
            return true
        }else{
            displayAlert(title, message: message, completion: {result in})
            return false
        }
        
    }
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        if NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(candidate){
            return true
        }else {
            displayAlert(type: "email_invalid", completion: {result in })
            return false
        }
        
    }
    
    func validatePassword(pass: String, cpass: String) -> Bool{
        
        if pass.characters.count > 5 {
            
            if pass == cpass{
                return true
            }else{
                displayAlert("Password Error", message: "Password does not match", completion: {result in})
                return false
            }
            
        }else{
            displayAlert("Password Error", message: "Password needs to be at least 6 characters", completion: {result in})
            return false
        }
        
    }
    
    func displayAlert( title: String = "", message: String = "", type: String = "", cancelAction: Bool = false, completion: Bool -> () ){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var mTitle = title
        var mMessage = message
        
        switch type {
        case "offline": // Network error
            mTitle = "Offline"
            mMessage = "You're currently offline, please try again when connected"
        case "email_invalid":
            mTitle = "Not Valid"
            mMessage = "Please enter a valid email address"
        case "does_not_exist":
            mTitle = "Doesn't exist"
            mMessage = "The email you entered doesn't exist, please check the email and try again"
        case "pass_invalid":
            mTitle = "Wrong password"
            mMessage = "Password is not correct, please try again"
        default: break
            
        }
        
        let alert = UIAlertController(title: mTitle, message: mMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){ UIAlertAction in
            completion(true)
            })
        
        
        if cancelAction {
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default){ UIAlertAction in
                completion(false)
                })
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            appDelegate.window?.currentViewController()!.presentViewController(alert, animated: true, completion: nil)
        })
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}