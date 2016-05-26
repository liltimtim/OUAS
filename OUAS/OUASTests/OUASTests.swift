//
//  OUASTests.swift
//  OUASTests
//
//  Created by Timothy Barrett on 4/26/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import XCTest
import Parse
@testable import OUAS

class UserTests : XCTestCase {
    func testAuthenticateUser() {
        let exp = expectationWithDescription("Authenticate a user")
        GameStore.shared.authenticate("liltimtim", password: "password1") { (currentUser, error) in
            XCTAssertNotNil(currentUser)
            XCTAssertNil(error)
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testSignUpUser() {
        
    }
    
    func testGetPreviousGames() {
        
    }
    
    func testGetChallenges() {
        
    }
    
    func testGetActiveGames() {
        let exp = expectationWithDescription("Get active games for owner")
        XCTAssertNotNil(PFUser.currentUser())
        GameStore.shared.getActiveGames { (games, error) in
            XCTAssertNotNil(games)
            XCTAssertNil(error)
            XCTAssertGreaterThan(games!.count, 0)
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
}

class GameTests : XCTestCase {
    func testCreateGame() {
        let exp = expectationWithDescription("Create a game")
        XCTAssertNotNil(PFUser.currentUser())
        Game.createGame(withTitle: "My Game", withOwner: PFUser.currentUser()!) { (game, error) in
            XCTAssertNotNil(game)
            XCTAssertNil(error)
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testEndGame() {
        let exp = expectationWithDescription("Create and end game")
        XCTAssertNotNil(PFUser.currentUser())
        Game.createGame(withTitle: "My Game End Game", withOwner: PFUser.currentUser()!) { (game, error) in
            XCTAssertNotNil(game)
            XCTAssertNil(error)
            game?.endGame({ (success, error) in
                XCTAssertTrue(success)
                XCTAssertNil(error)
                exp.fulfill()
            })
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testPostNewGameContent() {
        let exp = expectationWithDescription("Create game and post content")
        XCTAssertNotNil(PFUser.currentUser())
        Game.createGame(withTitle: "My Game with Content", withOwner: PFUser.currentUser()!) { (game, error) in
            XCTAssertNotNil(game)
            game?.postNewContent(withContent: "My awesome content is so awesome!", completion: { (success, error) in
                XCTAssertTrue(success)
                XCTAssertNil(error)
                exp.fulfill()
            })
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
}