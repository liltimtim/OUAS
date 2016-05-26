//
//  ActiveStoriesTableViewController.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/25/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit

class ActiveStoriesTableViewController: UITableViewController {
    private var activeGames:[Game] = [Game]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: ActiveStoryCell.nibName, bundle: nil), forCellReuseIdentifier: ActiveStoryCell.reuseIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activeGames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ActiveStoryCell.reuseIdentifier, forIndexPath: indexPath) as! ActiveStoryCell
        cell.storyTitle.text = activeGames[indexPath.row].title
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
        
    }
}

extension ActiveStoriesTableViewController {
    private func refreshTable() {
        GameStore.shared.getActiveGames { (games, error) in
            if error == nil {
                if games != nil {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.activeGames = games!
                        self.tableView.reloadData()
                    })
                } else {
                    // display no games error
                    print("No Active Games")
                }
            } else {
                // display regular error
                print(error)
            }
        }
    }
}
