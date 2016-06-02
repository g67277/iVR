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
    
    @IBOutlet weak var signinView: UIView!
    // Manual Login
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    // Facebook button
    @IBOutlet weak var fbLoginBtn: FBSDKLoginButton!
    
    // Class declerations
    var validation = Validation()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Facebook button elements
        fbLoginBtn.readPermissions = ["public_profile", "email", "user_friends"]
        fbLoginBtn.delegate = self
        
        enterAnimation()
    }
    
    func enterAnimation(){
        
        let xPosition = signinView.frame.origin.x
        
        //View will slide 20px up
        let yPosition = signinView.frame.origin.y - 70
        
        let height = signinView.frame.size.height
        let width = signinView.frame.size.width
        
        UIView.animateWithDuration(0.7, animations: {
            
            self.signinView.frame = CGRectMake(xPosition, yPosition, height, width)
            
        })
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
        // Checks if the email permission was granted, if not, an account can not be created and an alert is sent out
        
         if result.token != nil{
           if result.grantedPermissions.contains("email"){
                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                self.firebaseAuth(credential)
            }
         }else if !Reachability.isConnectedToNetwork(){
            validation.displayAlert("Offline", message: "You're currently offline, please try again when connected")
         }else{
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
            validation.displayAlert("Signup Failed", message: "We need your email to create your unique account.  Please try again")
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
    
    // Segue methods ----------------------------------------------------------------------------------------
    
    @IBAction func returnToLogInScreen (segue:UIStoryboardSegue) {
        
    }
    
    //-------------------------------------------------------------------------------------------------------

    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}