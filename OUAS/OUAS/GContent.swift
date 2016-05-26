//
//  GContent.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/25/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation
import Parse
class GContent: NSObject {
    private(set) var owner:PFUser!
    private(set) var content:String!
    private(set) var game:Game!
    private override init() { super.init() }
    
    init (withOwner owner:PFUser, withContent content:String, withGame game:Game) {
        self.owner = owner
        self.content = content
        self.game = game
    }
    
    func toPFObject() -> PFObject {
        let object = PFObject(className: "Content")
        object["owner"] = owner
        object["content"] = content
        object["postedOn"] = NSDate()
        object["game"] = game.toPFObject()
        return object
    }
}