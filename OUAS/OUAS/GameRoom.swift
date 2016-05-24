//
//  GameRoom.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/23/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation
import Parse
class GameRoom: NSObject {
    private(set) var owner:Player!
    private(set) var oponent:Player?
    private(set) var gameActive:Bool = true
    private var gameRoomObject:PFObject!
    init ( withOwner owner:Player ) {
        self.owner = owner
        gameRoomObject = PFObject(className: "GameRoom")
        self.gameActive = true
    }
    
    static func fromPFObject(object:PFObject) -> GameRoom? {
        guard let ownerObject = object["owner"] as? PFObject else { return nil }
        guard let player = Player.fromPFObject(ownerObject) else { return nil }
        guard let gameActive = object.objectForKey("game_active") as? Bool else { return nil }
        let gameRoom = GameRoom(withOwner: player)
        gameRoom.gameActive = gameActive
        gameRoom.gameRoomObject = object
        return gameRoom
    }
    
    func addOpponent(withPlayerObject player:Player, completion:(success:Bool, error:NSError?)->Void) {
        self.oponent = player
        self.toPFObject().saveInBackgroundWithBlock { (result, error) in
            completion(success: result, error: error)
        }
    }
    
    func endGame(completion:(success:Bool, error:NSError?)->Void) {
        gameActive = false
        toPFObject().saveInBackgroundWithBlock { (success, error) in
            completion(success: success, error: error)
        }
    }
    
    func postNewContent(withContent content:String, withContentOwner owner:PFUser, completion:(success:Bool, error:NSError?)->Void) {
        if gameRoomObject.objectId != nil {
            GameContent(withOwner: owner, withContent: content, withGameRoomID: gameRoomObject.objectId!).toPFObject().saveInBackgroundWithBlock({ (result, error) in
                completion(success: result, error: error)
            })
        } else {
            completion(success: false, error: NSError(domain: "GameRoom", code: 0, userInfo: ["error":"Game Room does not have an object iD"]))
        }
    }
    
    func getGameContent(completion:(content:[GameContent]?, error:NSError?)->Void) {
        if gameRoomObject.objectId != nil {
            let query = PFQuery(className: "GameContent")
            query.whereKey("game_room_id", equalTo: gameRoomObject.objectId!)
            query.findObjectsInBackgroundWithBlock({ (objects, error) in
                if error == nil {
                    if objects != nil {
                        var gameRoomContents = [GameContent]()
                        for object in objects! {
                            if let object = GameContent.fromPFObject(object) {
                                gameRoomContents.append(object)
                            }
                        }
                        completion(content: gameRoomContents, error: nil)
                    } else {
                        completion(content: nil, error: nil)
                    }
                } else {
                    completion(content: nil, error: error)
                }
            })
            
        } else {
            completion(content: nil, error: NSError(domain: "GameRoom", code: 0, userInfo: ["error":"Game Room does not have an object ID"]))
        }
        
    }
    
    func toPFObject() -> PFObject {
        let object = self.gameRoomObject
        object["owner"] = owner.toPFObject()
        if oponent != nil {
            object["oponent"] = oponent!.toPFObject()
        }
        object["game_active"] = gameActive
        return object
    }
}