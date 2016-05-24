//
//  Player.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/23/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation
import Parse
class Player: NSObject {
    private(set) var username:String?
    private(set) var id:String?
    private var playerObject:PFUser!
    init (withUsername username:String, withObjectID id:String) {
        self.username = username
        self.id = id
        playerObject = PFUser()
    }
    
    func toPFObject() -> PFUser {
        print(playerObject)
        return playerObject
    }
    
    static func fromPFObject(object:PFObject) -> Player? {
        guard let playerObject = object as? PFUser else { return nil }
        guard let username = playerObject.username, id = object.objectId else { return nil }
        let player = Player(withUsername: username, withObjectID: id)
        player.playerObject = playerObject
        return player
    }
}