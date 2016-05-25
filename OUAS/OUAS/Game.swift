//
//  Game.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/24/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation
import Parse
class Game: NSObject {
    private(set) var object : PFObject!
    private(set) var title : String!
    private(set) var owner : PFUser!
    private(set) var id : String!
    private(set) var isActive : Bool!
    
    private override init () { super.init() }
    
    private init (withTitle title:String, withOwner owner:PFUser, withObject object:PFObject, withID id:String, isActive:Bool) {
        super.init()
        self.title = title
        self.owner = owner
        self.object = object
        self.id = id
        self.isActive = isActive
    }
    
    func toPFObject() -> PFObject {
        return object
    }
    
    static func initWithObject(object:PFObject) -> Game? {
        guard let owner = object.objectForKey("owner") as? PFUser, title = object.objectForKey("title") as? String, id = object.objectId, isActive = object.objectForKey("isActive") as? Bool else { return nil }
        return Game(withTitle: title, withOwner: owner, withObject: object, withID: id, isActive: isActive)
    }
    
}