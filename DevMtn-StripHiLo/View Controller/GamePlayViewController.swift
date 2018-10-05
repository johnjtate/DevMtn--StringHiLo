//
//  GamePlayViewController.swift
//  DevMtn-StripHiLo
//
//  Created by John Tate on 10/4/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class GamePlayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Properties
    
    var round: Int = 0
    var playerScore: Int = 0
    // index 0-4 of stick figure images, with 0 being full clothed and 4 being naked
    var stickFigureImageIndex: Int = 0
    var endGameFlag = false
    var firstCardSuit: String = ""
    var firstCardValue: String = ""
    var secondCardSuit: String = ""
    var secondCardValue: String = ""
    
    // MARK: - GamePlay Methods
    
    func startNewGame() {
        presentStartGameMessage()
        round = 1
        playerScore = 0
        endGameFlag = false
        startNewRound()
    }
    
    func startNewRound() {
        // TODO: display some sort of message that the round has started
        round += 1
        playerScore += 1
        // start with index 0 of indices 0-4 as game progresses and player guesses incorrectly
        stickFigureImageIndex = 0
        
        // draw 2 cards
        CardController.shared.fetchCard(count: 2) { (cards) in
            guard let cards = cards else { return }
            let firstCard = cards[0]
            let secondCard = cards[1]
            
            // set suit and value properties
            self.firstCardSuit = firstCard.suit
            self.firstCardValue = firstCard.value
            self.secondCardSuit = secondCard.suit
            self.secondCardValue = secondCard.value
            
            // fetch card images
            // display the first; only display the second once the player chooses higher or lower
        }
    }
    
    func compareCards() {
        
        
        
        
        // pass in values of card 1 and card 2
        // compare card values
        // if player guess matches card values, score +1 and call startRound()
        // if player guess does not match card comparison, store stays the same, call incrementStickFigureImage, and call startRound()
    }
    
    func incrementStickFigureImage() {
        // increment stick figure image index; once reaches 4, end the game
        if stickFigureImageIndex <= 2 {
            stickFigureImageIndex += 1
        } else {
            endGame()
        }
    }
    
    func endGame() {
        endGameFlag = true
        presentEndGameMessage()
    }
    
    func presentStartGameMessage() {
        let alertController = UIAlertController(title: "New Game", message: "Guess whether the second card is higher than or lower than the first card.  Each time you are wrong, the stick man removes another piece of clothing.  Once he is naked, you lose.", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Okay!", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        
        // need to put this in a UIViewController
        present(alertController, animated: true)
    }
    
    func presentEndGameMessage() {
        let alertController = UIAlertController(title: "Game Over", message: "Your sitck man has no clothes left to take off. ☹️" , preferredStyle: .alert)
        let startNewGameAction = UIAlertAction(title: "Start New Game", style: .default) { (_) in
            self.startNewGame()
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(startNewGameAction)
        alertController.addAction(dismissAction)
        
        // need to put this in a UIViewController
        present(alertController, animated: true)
    }
}
