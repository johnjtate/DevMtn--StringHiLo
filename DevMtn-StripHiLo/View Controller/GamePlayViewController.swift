//
//  GamePlayViewController.swift
//  DevMtn-StripHiLo
//
//  Created by John Tate on 10/4/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class GamePlayViewController: UIViewController {

    @IBOutlet weak var stripMan: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var compareCardImage: UIImageView!
    @IBOutlet weak var drawCardImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: .green, bottomColor: #colorLiteral(red: 0.2431372549, green: 0.4431372549, blue: 0.1294117647, alpha: 1))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scoreLabel.text = "Score: \(playerScore)"
        startNewGame()
    }
    
    // MARK: - Properties
    
    var playerScore: Int = 0
    // index 0-4 of stick figure images, with 0 being full clothed and 4 being naked
    var stickFigureImageIndex: Int = 0
    var endGameFlag = false
    var firstCardSuit: String = ""
    var firstCardValue: String = ""
    var secondCardSuit: String = ""
    var secondCardValue: String = ""
    // 0 is default, 1 is guess low, 2 is guess high
    var playerGuessesState: Int = 0
    
    // MARK: - GamePlay Methods
    
    func updateStickFigure() {
        if stickFigureImageIndex == 0 {
            stripMan.image = UIImage(named: "image001")
        }
        if stickFigureImageIndex == 1 {
            stripMan.image = UIImage(named: "image002")
        }
        if stickFigureImageIndex == 2 {
            stripMan.image = UIImage(named: "image003")
        }
        if stickFigureImageIndex == 3 {
            stripMan.image = UIImage(named: "image004")
        }
        if stickFigureImageIndex == 4 {
            stripMan.image = UIImage(named: "image005")
            endGame()
        }
    }
    
    func startNewGame() {
        presentStartGameMessage()
        playerScore = 0
        scoreLabel.text = "Score: \(playerScore)"
        endGameFlag = false
        playerGuessesState = 0
        stickFigureImageIndex = 0
        updateStickFigure()
        drawCardImage.image = UIImage(named: "cardback")
        drawFirstCard()
        startNewRound()
    }
    
    func startNewRound() {
        playerGuessesState = 0
        playerScore += 1
        drawCardImage.image = UIImage(named: "cardback")
    }
    
    func drawFirstCard() {
        
        CardController.shared.fetchCard(count: 1) { (cards) in
            guard let card = cards?.first else { return }
            
            // set suit and value properties
            self.firstCardSuit = card.suit
            self.firstCardValue = card.value
            
            CardController.shared.fetchCardImage(card: card, completion: { (image) in
                DispatchQueue.main.async {
                    self.compareCardImage.image = image
                }
            })
        }
    }
    
    func drawSecondCard() {
        
        CardController.shared.fetchCard(count: 1) { (cards) in
            guard let card = cards?.first else { return }
            
            // set suit and value properties
            self.secondCardSuit = card.suit
            self.secondCardValue = card.value
            
            CardController.shared.fetchCardImage(card: card, completion: { (image) in
                DispatchQueue.main.async {
                    self.drawCardImage.image = image
                }
            })
        }
    }
    
    func compareCards() -> Bool {
        
        var cardValueDictionary: [String:Int] = [:]
        cardValueDictionary = ["2" : 2, "3" : 3, "4" : 4, "5" : 5, "6" : 6, "7" : 7, "8" : 8, "9" : 9, "10" : 10, "JACK" : 11, "QUEEN" : 12, "KING" : 13, "ACE" : 14]
        
        let compareCardOrdinal = cardValueDictionary[firstCardValue]
        let drawCardOrdinal = cardValueDictionary[secondCardValue]
        var playerGuessedRight: Bool = false
        
        guard let drawCard = drawCardOrdinal, let compareCard = compareCardOrdinal else { return false }
        
        if playerGuessesState == 1 && drawCard < compareCard {
            playerGuessedRight = true
        }
        if playerGuessesState == 1 && drawCard > compareCard {
            playerGuessedRight = false
        }
        if playerGuessesState == 2 && drawCard < compareCard {
            playerGuessedRight = false
        }
        if playerGuessesState == 2 && drawCard > compareCard {
            playerGuessedRight = true
        }
        // if cards of same value but different suits, treat as if player guessed right
        if drawCard == compareCard {
            playerGuessedRight = true
        }
        
        return playerGuessedRight
    }
    
    func evaluateGuess() {
        if compareCards() {
            playerScore += 1
            scoreLabel.text = "Score: \(playerScore)"
            startNewRound()
        } else {
            incrementStickFigureImage()
            scoreLabel.text = "Score: \(playerScore)"
            updateStickFigure()
            startNewRound()
        }
    }
    
    func incrementStickFigureImage() {
        // increment stick figure image index; once reaches 4, end the game
        if stickFigureImageIndex <= 3 {
            stickFigureImageIndex += 1
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
        
        present(alertController, animated: true)
    }
    
    @IBAction func lowButtonTapped(_ sender: UIButton) {
        playerGuessesState = 1
        drawSecondCard()
        compareCards()
        evaluateGuess()
    }
    
    @IBAction func highButtonTapped(_ sender: UIButton) {
        playerGuessesState = 2
        drawSecondCard()
        compareCards()
        evaluateGuess()
    }
}
