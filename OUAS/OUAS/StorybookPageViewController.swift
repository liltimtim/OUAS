//
//  StorybookPageViewController.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/31/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit

class StorybookPageViewController: UIPageViewController {
    
    private let loadingView = LoadingViewController()
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [LoadingViewController()]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setViewControllers([loadingView], direction: .Forward, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension StorybookPageViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return orderedViewControllers.first
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return orderedViewControllers.first
    }
}
