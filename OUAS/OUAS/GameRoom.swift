//
//  GameRoom.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/23/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation

class GameRoom : NSObject {
    private(set) var id:String?
    private(set) var authorizedPlayers:[Player]?
    private(set) var currentPlayer:Player?
    private(set) var story_content : [StoryContent]?
    var accessCode:Int?
    private(set) var host:String?
    init(withRoomID id:String) {
        super.init()
        self.id = id
    }
    
    func getGameContent(completion:(content:[StoryContent], error:NSError?)->Void) {
        
    }
    
    func updateContent(withNewContent content:StoryContent, completion:(success:Bool, error:NSError?)->Void) {
        
    }
}