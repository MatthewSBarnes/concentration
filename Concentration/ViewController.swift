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
    
    @IBAction func NewGame(_ sender: UIButton) {
        game.resetCards()
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        ViewController.themeLabels.removeAll()
        updateViewFromModel()
    }
    var flipCount = 0 { didSet { flipCountLabel.text = "Score: \(flipCount)" } }

    @IBAction func tapCard(_ sender: UIButton) {
        if !game.roundOver {
            if let cardNumber = cardButtons.index(of: sender) {
                game.chooseCard(at: cardNumber)
                updateViewFromModel()
            } else {
                print("Tapped Card not found in button array")
            }
        }
    }
    
    func updateViewFromModel() {
        if ViewController.themeLabels.isEmpty {
            let randomThemeIdx = Int(arc4random_uniform(UInt32(ViewController.themes.count)))
            ViewController.theme = ViewController.themes[randomThemeIdx]
            ViewController.themeLabels = ViewController.theme[1] as! [String]
        }
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
                    button.backgroundColor = card.isMatched ? ViewController.theme[3] as! UIColor : ViewController.theme[2] as! UIColor
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
    // Theme [Name, [Values], Back Colour, Matched Colour]
    static var themes = [
        ["Letters", ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"], #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)],
        ["Weather", ["❄️", "🌪", "☀️", "☔️", "💨", "🌈", "🌤", "🌦", "⛅️", "🌧", "☁️", "⛈"], #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)],
        ["Animals", ["🐶", "🐰", "🦊", "🐼", "🐸", "🙉", "🙊", "🐯", "🐨", "🐱", "🐹", "🐻"], #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)],
        ["Flags", ["🏳️", "🏴", "🏁", "🚩", "🏳️‍🌈", "🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴"], #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)],
        ["Halloween", ["👻", "👽", "☠️", "🙀", "🎃", "🤡", "😈", "👹", "👺", "😱", "🍭", "🍬"], #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)],
        ["Faces", ["😀", "😆", "😅", "😇", "😎", "🧐", "😫", "😡", "😤", "🤯", "😥", "😛"], #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)],
    ]

    static var theme = [Any]()
    
    static var themeLabels = [String]()
    
    var label = [Int:String]()
    
    func label(for card: Card) -> String {
        if label[card.identifier] == nil, ViewController.theme.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(ViewController.themeLabels.count)))
            label[card.identifier] = ViewController.themeLabels.remove(at: randomIndex)
        }
        return label[card.identifier] ?? "?"
    }
}

