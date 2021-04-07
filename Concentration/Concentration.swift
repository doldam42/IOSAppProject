//
//  Concentration.swift
//  Concentration
//
//  Created by Kim Taeseon on 2018. 5. 10..
//  Copyright © 2018년 connect.foundation.sr9872. All rights reserved.
//

import Foundation

struct Concentration {
//    [C2-9]
    private(set) var cards = [Card]()
//    [C1-1]
//    [C2-8]
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter{ cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
//        [C2-10]
        assert(cards.indices.contains(index), "Concentration.chooseCard(at:\(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
// [C1-2]
//                indexOfOneAndOnlyFaceUpCard = nil
            } else {
// [C1-3]
//                for flipDownIndex in cards.indices {
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
//        [C2-11]
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least on pair of cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }

    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

