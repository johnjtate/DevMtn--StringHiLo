//
//  Card.swift
//  DevMtn-StripHiLo
//
//  Created by John Tate on 10/4/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

struct DeckDictionary: Decodable {
    
    // MARK: - Properties
    let cards: [Card]
}

struct Card: Decodable {
    
    let value: String
    let suit: String
    let image: String
}

