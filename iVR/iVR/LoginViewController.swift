//
//  LoginViewController.swift
//  iVR
//
//  Created by Nazir Shuqair on 6/1/16.
//  Copyright © 2016 iVR. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    // Manual Login
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    // Facebook button
    @IBOutlet weak var fbLoginBtn: FBSDKLoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Facebook button elements
        fbLoginBtn.readPermissions = ["public_profile", "email", "user_friends"]
        fbLoginBtn.delegate = self
        
    }
    
    // If user was already logged in and token exists, log user in automatically
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if user != nil {
                self.loginAccepted()
            }
        }
    }
    
    // Main function that takes in credentials from all types of logins and does the final sign in (might need to be modified if the credientials are different from different types
    private func firebaseAuth(credentials: FIRAuthCredential){
        
        FIRAuth.auth()?.signInWithCredential(credentials) { (user, error) in
            if error == nil {
                print("\(user?.displayName) has been logged in")
                self.loginAccepted()
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    
    
    // Facebook Login methods ------------------------------------------------------------------------------
    // This is invoked when facebook authenticates
    internal func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
        
        if error != nil {
            print(error.localizedDescription)
            return
        }
        
        if result.token != nil{
            let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
            self.firebaseAuth(credential)
        }
    }
    
    // Required for facebook deletage, login will be done else where
    internal func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        
    }
    //-------------------------------------------------------------------------------------------------------
    
    
    // This is invoked either when the log in is successful, or if the user is already logged in
    private func loginAccepted(){
        //This will change once paging is implemented**
        let mainPage = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = mainPage
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
