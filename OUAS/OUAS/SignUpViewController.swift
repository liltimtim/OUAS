//
//  SignUpViewController.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/23/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func signUpPressed(sender: AnyObject) {
        if validateFields() {
            GameStore.shared.signUp(withUsername: usernameField.text!, withEmail: emailField.text!, withPassword: passwordField.text!, completion: { (user, error) in
                if user != nil {
                    guard let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() else {
                        // displaye error
                        print("Could not instantiate the view")
                        return
                    }
                    self.presentViewController(mainView, animated: true, completion: nil)
                } else {
                    print(error)
                }
            })
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func validateFields() -> Bool {
        if usernameField.text != nil && emailField.text != nil && passwordField.text != nil && confirmPasswordField.text != nil {
            return true
        }
        
        return false
    }

}
