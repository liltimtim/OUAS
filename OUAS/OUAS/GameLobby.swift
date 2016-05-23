//
//  GameLobby.swift
//  OUAS
//
//  Created by Timothy Barrett on 5/23/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation

class GameLobby: NSObject {
    private(set) var id:String?
    private(set) var publicGame:Bool = false
    private(set) var accessCode:Int?
    private(set) var players:[Player]?
    private(set) var host:String?
}