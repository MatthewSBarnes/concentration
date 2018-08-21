//
//  Concentration.swift
//  Concentration
//
//  Created by Matthew Barnes on 2018-08-20.
//  Copyright © 2018 Matthew Barnes. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    var roundOver = false
    
    var score = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isFaceUp {
            score += 1
            if !cards[index].isMatched {
                if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                    if cards[matchIndex].identifier == cards[index].identifier {
                        cards[matchIndex].isMatched = true
                        cards[index].isMatched = true
                        score -= 4
                    }
                    if cards[index].hasBeenFaceUp { score += 1 }
                    cards[index].isFaceUp = true
                    cards[index].hasBeenFaceUp = true
                    indexOfOneAndOnlyFaceUpCard = nil
                } else {
                    // flip all cards down
                    for flipDownIndex in cards.indices {
                        cards[flipDownIndex].isFaceUp = false
                    }
                    // flip the card i just selected face up
                    if cards[index].hasBeenFaceUp { score += 1 }
                    cards[index].isFaceUp = true
                    cards[index].hasBeenFaceUp = true
                    indexOfOneAndOnlyFaceUpCard = index
                }
                if allCardsAreMatched() {
                    roundOver = true
                }
            }
        }
    }
    
    func allCardsAreMatched() -> Bool {
        for index in cards.indices {
            if cards[index].isMatched == false {
                return false
            }
        }
        return true
    }
    
    init(numberOfPairsOfCards: Int) {
        var spawn = [Card]()
        for _ in 0..<numberOfPairsOfCards {
            // pass by copy, so dealing with 3 different cards.
            let card = Card()
                spawn += [card, card]
        }
        for _ in 0..<spawn.count {
            let randomIndex = Int(arc4random_uniform(UInt32(spawn.count)))
            cards.append(spawn.remove(at: randomIndex))
        }
    }
}
