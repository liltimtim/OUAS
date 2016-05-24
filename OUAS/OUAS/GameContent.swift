//
//  GameContent.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/24/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation
import Parse
class GameContent: NSObject {
    private(set) var createdOn:NSDate!
    private(set) var owner:PFUser!
    private(set) var content:String!
    private(set) var object:PFObject?
    private(set) var gameRoomID:String!
    init (withOwner owner:PFUser, withContent content:String, withGameRoomID id:String) {
        self.owner = owner
        self.content = content
        self.createdOn = NSDate()
        self.gameRoomID = id
    }
    
    func toPFObject() -> PFObject {
        let object = PFObject(className: "GameContent")
        object["created_on"] = createdOn
        object["owner"] = owner
        object["content"] = content
        object["game_room_id"] = gameRoomID
        return object
    }
    
    static func fromPFObject(object:PFObject) -> GameContent? {
        guard let owner = object.objectForKey("owner") as? PFUser, content = object.objectForKey("content") as? String, createdOn = object.objectForKey("created_on") as? NSDate, id = object.objectForKey("game_room_id") as? String else { return nil }
        let gameContent = GameContent(withOwner: owner, withContent: content, withGameRoomID: id)
        gameContent.createdOn = createdOn
        return gameContent
    }
}