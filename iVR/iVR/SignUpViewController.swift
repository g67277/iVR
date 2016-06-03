//
//  SignUpViewController.swift
//  iVR
//
//  Created by Nazir Shuqair on 6/2/16.
//  Copyright © 2016 iVR. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    let CLASSID = "SignUpViewController"
    
    @IBOutlet weak var nameField: UITextField! // Will need to add this later
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    var validation = Validation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpBtn(sender: AnyObject) {
        emailSignUp()
    }
    // Email & Password Signup methods ----------------------------------------------------------------------
    
    internal func emailSignUp(){
        
        if Reachability.isConnectedToNetwork(){
            FIRAuth.auth()?.createUserWithEmail(emailField.text!, password: passField.text!) { (user, error) in
                if error != nil {
                    print("\(self.CLASSID):   \(error?.localizedDescription)")
                }else{
                    print("\(user?.displayName) has been logged in")
                    self.signUpAccepted()
                }
            }
        }else{
            validation.displayAlert(type: "offline")
        }
    }
    
    //------------------------------------------------------------------------------------------------------

    
    // This is invoked either when the log in is successful, or if the user is already logged in
    private func signUpAccepted(){
        //This will change once paging is implemented**
        let mainPage = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = mainPage
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
