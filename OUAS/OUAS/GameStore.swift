//
//  GameStore.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/24/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation
import Parse
class GameStore: NSObject {
    static let shared : GameStore = GameStore()
    private(set) var currentUser:PFUser!
    
    private override init () { super.init() }
    
    func authenticate(username:String, password:String, completion:(currentUser:PFUser?, error:NSError?)->Void) {
        PFUser.logInWithUsernameInBackground(username, password: password) { (user, error) in
            if error == nil {
                if user != nil {
                    self.currentUser = user!
                    completion(currentUser: user, error: nil)
                } else {
                    completion(currentUser: nil, error: NSError(domain: "GameStore", code: 0, userInfo: ["error":"Could not authenticate user"]))
                }
            } else {
                completion(currentUser: nil, error: error)
            }
        }
    }
    
    func signUp(email:String, username:String, password:String, completion:(currentUser:PFUser?, error:NSError?)->Void) {
        let user = PFUser()
        user.username = username
        user.password = password
        user.email = email
        user.signUpInBackgroundWithBlock { (success, error) in
            if success {
                completion(currentUser: user, error: nil)
            } else {
                completion(currentUser: nil, error: error)
            }
        }
    }
    
    func updateGameContent(withContent content:GContent, completion:(success:Bool, error:NSError?)->Void) {
        content.toPFObject().saveInBackgroundWithBlock { (success, error) in
            completion(success: success, error: error)
        }
    }
    
    func joinGame() {
        
    }
    
    func getActiveGames(completion:(games:[Game]?, error:NSError?)->Void) {
        let query = PFQuery(className: "Game")
        query.whereKey("isActive", equalTo: true)
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error == nil {
                if objects != nil {
                    var games = [Game]()
                    for object in objects! {
                        if let game = Game.initWithObject(object) {
                            games.append(game)
                        }
                    }
                    completion(games: games, error: nil)
                } else {
                    completion(games: nil, error: NSError(domain: "GameStore", code: 0, userInfo: ["error":"No active games found"]))
                }
            } else {
                completion(games: nil, error: error)
            }
        }
    }
}