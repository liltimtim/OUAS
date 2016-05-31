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
    private(set) var isActive : Bool! {
        didSet {
            object["isActive"] = isActive
        }
    }
    
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
    
    func endGame(completion:(success:Bool, error:NSError?)->Void) {
        if let user = PFUser.currentUser() {
            if user.objectId == owner.objectId {
                isActive = false
                toPFObject().saveInBackgroundWithBlock({ (success, error) in
                    completion(success: success, error: error)
                })
            } else {
                completion(success: false, error: NSError(domain: "Game", code: 0, userInfo: ["error":"You are not the owner of this game"]))
            }
        } else {
            completion(success: false, error: NSError(domain: "Game", code: 0, userInfo: ["error":"No User object found"]))
        }
    }
    
    func postNewContent(withContent story:String, completion:(success:Bool, error:NSError?)->Void) {
        let content = GContent(withOwner: owner, withContent: story, withGame: self)
        content.toPFObject().saveInBackgroundWithBlock { (success, error) in
            completion(success: success, error: error)
        }
    }
    
    func getGameContent(completion:(content:[GContent], error:NSError?)->Void) {
        let query = PFQuery(className: "Content")
        query.whereKey("game", equalTo: toPFObject())
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error == nil {
                print(objects)
                var contents = [GContent]()
                if objects != nil {
                    for object in objects! {
                        if let content = GContent.fromPFObject(object) {
                            contents.append(content)
                        }
                    }
                }
                completion(content: contents, error: nil)
            } else {
                completion(content: [GContent](), error: error)
            }
        }
    }
    
    static func createGame(withTitle title:String, withOwner owner:PFUser, completion:(game:Game?, error:NSError?)->Void) {
        let object = PFObject(className: "Game")
        object["title"] = title
        object["owner"] = owner
        object["isActive"] = true
        object.saveInBackgroundWithBlock { (success, error) in
            if success {
                completion(game: Game.initWithObject(object), error: nil)
            } else {
                completion(game: nil, error: error)
            }
        }
    }
    
    static func initWithObject(object:PFObject) -> Game? {
        guard let owner = object.objectForKey("owner") as? PFUser, title = object.objectForKey("title") as? String, id = object.objectId, isActive = object.objectForKey("isActive") as? Bool else { return nil }
        return Game(withTitle: title, withOwner: owner, withObject: object, withID: id, isActive: isActive)
    }
    
}