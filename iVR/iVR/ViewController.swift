//
//  ViewController.swift
//  iVR
//
//  Created by Nazir Shuqair on 5/27/16.
//  Copyright © 2016 iVR. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // This will be moved to the profile page**
    @IBAction func logout(sender: AnyObject) {
        
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        try! FIRAuth.auth()!.signOut()
        logoutAccepted()
    }
    
    private func logoutAccepted(){
        //This will change once paging is implemented**
        let loginPage = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = loginPage
    }
}

