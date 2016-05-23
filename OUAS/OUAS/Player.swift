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
    private(set) var parseObject:PFUser!
    
    init ( withParseObject object:PFUser) {
        self.parseObject = object
    }
    
    func getFriends(completion:(friends:[Player], error:NSError?)->Void) {
        let query = PFQuery(className: "Friends")
        completion(friends: [Player](), error: NSError(domain: "Player", code: 0, userInfo: ["error":"method incomplete"]))
    }
}