//
//  ViewController.swift
//  Concentration
//
//  Created by Matthew Barnes on 2018-08-04.
//  Copyright © 2018 Matthew Barnes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet var cardButtons: [UIButton]!

    @IBOutlet weak var flipCountLabel: UILabel!
    
    var flipCount = 0 { didSet { flipCountLabel.text = "Score: \(flipCount)" } }

    @IBAction func tapCard(_ sender: UIButton) {
        if !game.roundOver {
            if let cardNumber = cardButtons.index(of: sender) {
                game.chooseCard(at: cardNumber)
                updateViewFromModel()
            } else {
                print("Card not found :(")
            }
        }
    }
    
    func updateViewFromModel() {
        flipCount = game.score
        if !game.roundOver {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(label(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                } else {
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                }
            }
        } else {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                button.setTitle("😄", for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
                flipCountLabel.textColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        }
        
    }
    
    var labelChoices = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"]
    
    var label = [Int:String]()
    
    func label(for card: Card) -> String {
        if label[card.identifier] == nil, labelChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(labelChoices.count)))
            label[card.identifier] = labelChoices.remove(at: randomIndex)
        }
        return label[card.identifier] ?? "?"
    }
}

