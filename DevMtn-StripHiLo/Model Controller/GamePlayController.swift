//
//  GamePlayController.swift
//  DevMtn-StripHiLo
//
//  Created by John Tate on 10/4/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class GamePlayController {
    
    static let shared = GamePlayController()
    private init() {}
    
    var round: Int = 0
    var playerScore: Int = 0
    // index 0-4 of stick figure images, with 0 being full clothed and 4 being naked
    var stickFigureImageIndex: Int = 0
    var endGameFlag = false
    
    func startGame() {
        round = 1
        playerScore = 0
        endGameFlag = false
        startRound()
    }
    
    func startRound() {
        round += 1
        playerScore += 1
        // start with index 0 of indices 0-4 as game progresses and player guesses incorrectly
        stickFigureImageIndex = 0
        // draw 2 cards
    }
    
    func compareCards() {
        // pass in values of card 1 and card 2
        // compare card values
        // if player guess matches card values, score +1 and call startRound()
        // if player guess does not match card comparison, store stays the same, call incrementStickFigureImage, and call startRound()
    }
    
    func incrementStickFigureImage() {
        // increment stick figure image index
        if stickFigureImageIndex <= 2 {
            stickFigureImageIndex += 1
        } else {
            endGame()
        }
    }
    
    func endGame() {
        endGameFlag = true
    }
}

