//
//  OUASTests.swift
//  OUASTests
//
//  Created by Timothy Barrett on 4/26/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import XCTest
@testable import OUAS

class GameStoreTests: XCTestCase {
    func testCreateNewGameRoom() {
        let exp = expectationWithDescription("Create new game room")
        GameStore.shared.currentPlayer = CurrentPlayer(gamerTag: "liltimtim")
        GameStore.shared.createGame(withHost: GameStore.shared.currentPlayer.gamerTag!) { (gameRoom, error) in
            XCTAssertNotNil(gameRoom)
            XCTAssertNil(error)
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testGetAvailableGames() {
        let exp = expectationWithDescription("Get available game lobby rooms")
        GameStore.shared.currentPlayer = CurrentPlayer(gamerTag: "liltimtim")
        GameStore.shared.getAvailableGames { (rooms, error) in
            XCTAssertNotNil(rooms)
            XCTAssertNil(error)
            
            print(rooms?.count)
            for room in rooms! {
                print(room.id)
                XCTAssertNotNil(room.id)
                XCTAssertNotNil(room.host?)
            }
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
}
