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
            displayAlert(title, message: message)
            return false
        }
        
    }
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        if NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(candidate){
            return true
        }else {
            displayAlert("Invalid Email ", message: "Please enter a valid email")
            return false
        }
        
    }
    
    func validatePassword(pass: String, cpass: String) -> Bool{
        
        if pass.characters.count > 5 {
            
            if pass == cpass{
                return true
            }else{
                displayAlert("Password Error", message: "Password does not match")
                return false
            }
            
        }else{
            displayAlert("Password Error", message: "Password needs to be at least 6 characters")
            return false
        }
        
    }
    
    func displayAlert( title: String = "", message: String = "", type: String = ""){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var mTitle = title
        var mMessage = message
        
        switch type {
        case "offline": // Network error
            mTitle = "Offline"
            mMessage = "You're currently offline, please try again when connected"
        default: break
            
        }
        
        let alert = UIAlertController(title: mTitle, message: mMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        appDelegate.window?.rootViewController!.presentViewController(alert, animated: true, completion: nil)
        
    }
    
//     func displayAlert(title: String, message: String){
//        
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
//        appDelegate.window?.rootViewController!.presentViewController(alert, animated: true, completion: nil)
//
//    }
    
}