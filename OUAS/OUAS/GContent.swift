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
    
    static func fromPFObject(object:PFObject?) -> GContent? {
        guard let owner = object?["owner"] as? PFUser, content = object?["content"] as? String else { return nil }
        guard let gameObject = object?["game"] as? PFObject else { return nil }
        guard let game = Game.initWithObject(gameObject) else { return nil }
        return GContent(withOwner: owner, withContent: content, withGame: game)
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