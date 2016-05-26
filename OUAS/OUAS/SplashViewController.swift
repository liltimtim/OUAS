//
//  SplashViewController.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/25/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit
import Parse
class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if PFUser.currentUser() != nil {
            // pfuser exists
            self.performSegueWithIdentifier("showApp", sender: nil)
        } else {
            // no pfuser require login
            self.performSegueWithIdentifier("showLogin", sender: nil)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidAppear(animated)
        
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
