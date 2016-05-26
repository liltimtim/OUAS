//
//  ActiveStoryCell.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/25/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit

class ActiveStoryCell: UITableViewCell {
    @IBOutlet weak var storyTitle: UILabel!
    static let reuseIdentifier: String = "ActiveStoryCell"
    static let nibName: String = "ActiveStoryCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
