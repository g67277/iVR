//
//  ViewController.swift
//  firebaseT
//
//  Created by Nazir Shuqair on 6/2/16.
//  Copyright © 2016 iVR. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    var loginButton: FBSDKLoginButton = FBSDKLoginButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                print("user is logged in")
            } else {
                // No user is signed in.
                print("no user is logged in")
            }
        }
        
        // Optional: Place the button in the center of your view.
        self.loginButton.center = self.view.center
        self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        self.loginButton.delegate = self
        self.view!.addSubview(loginButton)

    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)

        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
            // ...
        }
        
        print("user logged in")
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("user logged out")
        try! FIRAuth.auth()!.signOut()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

