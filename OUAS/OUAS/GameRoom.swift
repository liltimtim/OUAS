//
//  GameRoom.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/23/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation

class GameRoom : NSObject {
    private(set) var id:String?
    private(set) var players : [Player]?
    private(set) var current_player:Player?
    private(set) var story_content : [StoryContent]?
    
    
}