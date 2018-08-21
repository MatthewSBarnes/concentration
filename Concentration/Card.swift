//
//  Card.swift
//  Concentration
//
//  Created by Matthew Barnes on 2018-08-20.
//  Copyright © 2018 Matthew Barnes. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var hasBeenFaceUp = false
    var isMatched = false
    var identifier: Int

    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
