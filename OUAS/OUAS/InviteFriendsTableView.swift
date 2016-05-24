//
//  InviteFriendsTableView.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/23/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit

class InviteFriendsTableView: UITableViewController {
    private var players = [Player]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: FriendCell.storyboardName, bundle: nil), forCellReuseIdentifier: FriendCell.reuseIdentifier)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshUsers()
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
        return players.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FriendCell.reuseIdentifier, forIndexPath: indexPath) as! FriendCell
        cell.friendLabel.text = players[indexPath.row].username
        return cell
    }
    
    private func refreshUsers() {
        GameStore.shared.findPlayers { (players, error) in
            if error == nil && players != nil {
                dispatch_async(dispatch_get_main_queue(), { 
                    self.players = players!
                    self.tableView.reloadData()
                })
            }
        }
    }
}
