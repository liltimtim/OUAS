//
//  FriendCell.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/24/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    @IBOutlet weak var friendLabel: UILabel!
    static let reuseIdentifier: String = "FriendCell"
    static let storyboardName: String = "FriendCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
