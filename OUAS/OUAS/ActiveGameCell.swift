//
//  ActiveGameCell.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/23/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit

class ActiveGameCell: UITableViewCell {
    @IBOutlet weak var currentPlayer: UILabel!
    @IBOutlet weak var pageCount: UILabel!
    static let reuseIdentifier: String = "ActiveGameCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
