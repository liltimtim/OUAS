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
    private(set) var currentUser:PFUser?
    private override init () {
        
    }
    
    // MARK: User Functions
    
    func authenticate(withUsername username:String, withPassword password:String, completion:(user:PFUser?, error:NSError?)->Void) {
        PFUser.logInWithUsernameInBackground(username, password: password) { (user, error) in
            self.currentUser = user
            
            if user?.objectId != nil && PFInstallation.currentInstallation().deviceToken != nil {
                let tokenObject = PFObject(className: "DeviceTokens")
                tokenObject["user"] = user!.objectId!
                tokenObject["deviceToken"] = PFInstallation.currentInstallation().deviceToken!
                tokenObject.saveInBackground()
            }
            completion(user: user, error: error)
        }
    }
    
    func signUp(withUsername username:String, withEmail email:String, withPassword password:String, completion:(user:PFUser?, error:NSError?)->Void) {
        let user = PFUser()
        user.username = username
        user.password = password
        user.email = email
        user.signUpInBackgroundWithBlock { (success, error) in
            self.currentUser = PFUser.currentUser()
            completion(user: PFUser.currentUser(), error: error)
        }
    }
    
    /*
    func addFriend(withPlayerObject player:Player, completion:(success:Bool, error:NSError?)->Void) {
        
    }
    
    func removeFriend(withPlayerObject player:Player, completion:(success:Bool, error:NSError?)->Void) {
        
    }
    */
    
    func createGame(withOwner owner:Player, completion:(gameObject:GameRoom?, error:NSError?)->Void) {
        let newRoom = GameRoom(withOwner: owner)
        let object = newRoom.toPFObject()
        print(object)
        object.saveInBackgroundWithBlock { (result, error) in
            if result {
                completion(gameObject: newRoom, error: nil)
            } else {
                completion(gameObject: nil, error: error)
            }
        }
    }
    
    func findPlayers(completion:(players:[Player]?, error:NSError?)->Void) {
        let query = PFUser.query()
        query?.findObjectsInBackgroundWithBlock({ (objects, error) in
            if error == nil {
                if objects != nil {
                    var players = [Player]()
                    for player in objects! {
                        if let aPlayer = Player.fromPFObject(player) {
                            players.append(aPlayer)
                        }
                    }
                    completion(players: players, error: nil)
                } else {
                    completion(players: nil, error: nil)
                }
            } else {
                completion(players: nil, error: error)
            }
        })
    }
    
    func invitePlayer(withUsername username:String, completion:(player:Player?, error:NSError?)->Void) {
        if let query = PFUser.query() {
            query.whereKey("username", equalTo: username)
            query.getFirstObjectInBackgroundWithBlock({ (object, error) in
                if object != nil && error == nil {
                    completion(player: Player.fromPFObject(object!), error: error)
                } else {
                    completion(player: nil, error: error)
                }
            })
        } else {
            completion(player: nil, error: NSError(domain: "GameStore", code: 0, userInfo: ["error":"Could not setup query"]))
        }
    }
    
}