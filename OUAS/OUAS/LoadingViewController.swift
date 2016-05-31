//
//  LoadingViewController.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/31/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    var currentGame:Game?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getGameContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getGameContent() {
        currentGame?.getGameContent({ (content, error) in
            print("Got game content")
            dispatch_async(dispatch_get_main_queue(), {
                self.performSegueWithIdentifier("showPages", sender: nil)
            })
        })
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
