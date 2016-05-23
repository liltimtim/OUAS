//
//  CurrentPlayer.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/23/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation

class CurrentPlayer: Player {
    private(set) var friends:[Player] = [Player]()
    
    
    func addFriend(withPlayerObject player:Player, completion:(success:Bool, error:NSError?)->Void) {
        friends.append(player)
        // add friend to server list
    }
    
    func removeFriend(withPlayerObject player:Player, completion:(success:Bool, error:NSError?)->Void) {
        if let index = friends.indexOf(player) {
            friends.removeAtIndex(index)
        }
    }
}