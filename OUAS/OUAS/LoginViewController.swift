//
//  LoginViewController.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/25/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginPressed(sender: AnyObject) {
        authenticate()
    }

}

extension LoginViewController {
    private func authenticate() {
        if usernameField.text != nil && passwordField.text != nil {
            GameStore.shared.authenticate(usernameField.text!, password: passwordField.text!, completion: { (currentUser, error) in
                if error == nil {
                    self.performSegueWithIdentifier("showApp", sender: nil)
                } else {
                    // show error
                    print(error)
                }
            })
        }
    }
}
