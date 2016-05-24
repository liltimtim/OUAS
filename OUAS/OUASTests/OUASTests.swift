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


class GameRoomTests : XCTestCase {
    func testCreateGame() {
        let exp = expectationWithDescription("Create a game")
        GameStore.shared.authenticate(withUsername: "liltimtim", withPassword: "password1") { (user, error) in
            XCTAssertNotNil(user)
            XCTAssertNil(error)
            print(user)
            print(error)
            let player = Player.fromPFObject(user!)!
            GameStore.shared.createGame(withOwner: player, completion: { (gameObject, error) in
                XCTAssertNotNil(gameObject)
                XCTAssertNil(error)
                exp.fulfill()
            })
        }
        waitForExpectationsWithTimeout(100, handler: nil)
    }
    
    func testCreateGameAddContent() {
        let exp = expectationWithDescription("Create a game and add content")
        GameStore.shared.authenticate(withUsername: "liltimtim", withPassword: "password1") { (user, error) in
            XCTAssertNotNil(user)
            XCTAssertNil(error)
            print(error)
            let player = Player.fromPFObject(user!)!
            GameStore.shared.createGame(withOwner: player, completion: { (gameObject, error) in
                XCTAssertNotNil(gameObject)
                XCTAssertNil(error)
                print(gameObject)
                gameObject!.postNewContent(withContent: "Hello world content", withContentOwner: user!, completion: { (success, error) in
                    XCTAssertTrue(success)
                    XCTAssertNil(error)
                    exp.fulfill()
                })
            })
        }
        waitForExpectationsWithTimeout(40, handler: nil)
    }
    
    func testCreateGameAddOpponent() {
        let exp = expectationWithDescription("Create a game and add opponent")
        GameStore.shared.authenticate(withUsername: "liltimtim", withPassword: "password1") { (user, error) in
            let player = Player.fromPFObject(user!)!
            GameStore.shared.createGame(withOwner: player, completion: { (gameObject, error) in
                gameObject?.addOpponent(withPlayerObject: player, completion: { (success, error) in
                    XCTAssertTrue(success)
                    XCTAssertNil(error)
                    exp.fulfill()
                })
            })
        }
        waitForExpectationsWithTimeout(400, handler: nil)
    }
    
    func testStartGameAndEndGame() {
        let exp = expectationWithDescription("Start and End a game")
        GameStore.shared.authenticate(withUsername: "liltimtim", withPassword: "password1") { (user, error) in
            let player = Player.fromPFObject(user!)!
            GameStore.shared.createGame(withOwner: player, completion: { (gameObject, error) in
                XCTAssertNotNil(gameObject)
                gameObject?.endGame({ (success, error) in
                    XCTAssertTrue(success)
                    XCTAssertNil(error)
                    exp.fulfill()
                })
            })
        }
        waitForExpectationsWithTimeout(40, handler: nil)
    }
    
    func testInvitePlayer() {
        let exp = expectationWithDescription("Invite player to game")
        GameStore.shared.invitePlayer(withUsername: "liltimtim") { (player, error) in
            XCTAssertNotNil(player)
            XCTAssertNil(error)
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(30, handler: nil)
    }
    
    func testAuthenticate() {
        let exp = expectationWithDescription("Test Authenticate User")
        GameStore.shared.authenticate(withUsername: "liltimtim", withPassword: "password1") { (user, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(user)
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testCreateUser() {
        let exp = expectationWithDescription("test authentication")
        GameStore.shared.signUp(withUsername: "liltimtim", withEmail: "liltimtim@gmail.com", withPassword: "password1") { (user, error) in
            XCTAssertNotNil(user)
            XCTAssertNil(error)
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
}