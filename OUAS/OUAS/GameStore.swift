//
//  GameStore.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/23/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation
import Parse
class GameStore: NSObject {
    static let shared:GameStore = GameStore()
    var currentPlayer:CurrentPlayer!
    private override init () {
        
    }
    
    func authenticate(withUsername username:String, withPassword password:String, completion:(success:Bool, error:NSError?)->Void) {
        PFUser.logInWithUsernameInBackground(username, password: password) { (user, error) in
            if user != nil && error == nil {
                self.currentPlayer = CurrentPlayer(gamerTag: user!.username!)
                completion(success: true, error: nil)
            }
            completion(success: false, error: error)
        }
    }
    
    func signUp(withUsername username:String, withEmail email:String, withPassword password:String, completion:(success:Bool, error:NSError?)->Void) {
        let user = PFUser()
        user.username = username
        user.password = password
        user.email = email
        user.signUpInBackgroundWithBlock { (success, error) in
            if success && error == nil {
                self.currentPlayer = CurrentPlayer(gamerTag: username)
            }
            completion(success: success, error: error)
        }
    }
    
    func getAvailableGames(completion:(rooms:[GameRoom]?, error:NSError?)->Void) {
        let query = PFQuery(className: "GameRoom")
        query.whereKey("public_game", equalTo: true)
        query.findObjectsInBackgroundWithBlock { (result, error) in
            if result != nil {
                var gameRooms = [GameRoom]()
                for room in result! {
                    
                    if let roomHost:String = room.objectForKey("host") as? String {
                        
                    }
                    if let roomID:String = room.objectId {
                        
                        gameRooms.append(GameRoom(withRoomID: roomID))
                    }
                }
                completion(rooms: gameRooms, error: nil)
            } else {
                completion(rooms: nil, error: error)
            }
        }
    }
    
    func postNewContent(forRoom gameRoom:GameRoom, withUserID userID:String, content:String, completion:(success:Bool, error:NSError?)->Void) {
        if gameRoom.id != nil {
            let object = PFObject(className: "GameContent")
            object.addObject(NSDate(), forKey: "posted_on")
            object.addObject(content, forKey: "content")
            object.addObject("room_id", forKey: gameRoom.id!)
            object.addObject("posted_by", forKey: userID)
            object.saveInBackgroundWithBlock { (result, error) in
                completion(success: result, error: error)
            }
        } else {
            completion(success: false, error: NSError(domain: "GameStore", code: 0, userInfo: ["error":"Game Room did not have an object ID"]))
        }
    }
    
    func getGameRoomContent(forGameRoomID id:String, completion:(content:[StoryContent]?, error:NSError?)->Void) {
        let query = PFQuery(className: "GameContent")
        query.orderByDescending("posted_on")
        query.whereKey("room_id", equalTo: id)
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error == nil && objects != nil {
                var stories = [StoryContent]()
                for story in objects! {
                    let aStory = StoryContent()
                    aStory.content = story.objectForKey("content") as? String
                    aStory.postedOn = story.objectForKey("posted_on") as? NSDate
                    stories.append(aStory)
                }
            } else {
                completion(content: nil, error: error)
            }
        }
    }
    
    func createGame(withHost username:String, withAccessCode code:Int?, completion:(gameRoom:GameRoom?, error:NSError?)->Void) {
        let pfGameRoom = PFObject(className: "GameRoom")
        pfGameRoom["current_player"] = currentPlayer.gamerTag
        pfGameRoom["public_game"] = true
        pfGameRoom["host"] = username
        
        pfGameRoom.saveInBackgroundWithBlock { (success, error) in
            if success && error == nil {
                if pfGameRoom.objectId != nil {
                    let gameRoom = GameRoom(withRoomID: pfGameRoom.objectId!)
                    completion(gameRoom: gameRoom, error: nil)
                } else {
                    completion(gameRoom: nil, error: NSError(domain: "GameStore", code: 0, userInfo: ["error":"No object ID was set"]))
                }
            } else {
                completion(gameRoom: nil, error: error)
            }
        }
    }
}