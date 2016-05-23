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
    private(set) var currentPlayer:CurrentPlayer!
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
    
    func getAvailableGames() {
        
    }
    
    func createGame() {
        
    }
    
    
    
}