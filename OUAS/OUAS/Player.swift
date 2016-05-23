//
//  Player.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/23/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation

class Player: NSObject {
    private(set) var gamerTag:String?
    
    required init ( gamerTag:String ) {
        super.init()
        self.gamerTag = gamerTag
    }
}