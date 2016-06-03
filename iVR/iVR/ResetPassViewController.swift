//
//  ResetPassViewController.swift
//  iVR
//
//  Created by Nazir Shuqair on 6/3/16.
//  Copyright © 2016 iVR. All rights reserved.
//

import UIKit
import FirebaseAuth

class ResetPassViewController: UIViewController {
    let CLASSID = "ResetPassViewController"
    
    let validation = Validation()

    
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ResetBtn(sender: AnyObject) {
        
        if Reachability.isConnectedToNetwork() {
            if self.validation.validateEmail(emailField.text!) {
                FIRAuth.auth()?.sendPasswordResetWithEmail(emailField.text!) { error in
                    if let error = error {
                        print("\(self.CLASSID):   \(error.localizedDescription)")
                        print("code: \(error.code)")
                        if error.code == 17011 {
                            self.validation.displayAlert(type: "does_not_exist", completion: {result in})
                        }
                    } else {
                        self.validation.displayAlert("Done", message: "Please check your email"){ result in
                            if result {
                                self.dismissViewControllerAnimated(true, completion: nil);
                            }
                        }
                    }
                }
            }
        }else{
            self.validation.displayAlert(type: "offline", completion: {result in})
        }
    }

}
