//
//  DiceHistory.swift
//  RollTheDice
//
//  Created by Melissa Elliston-Boyes on 11/07/2025.
//

import Foundation
import SwiftData

@Model
class DiceRoll {
    var total: Int
    var timeStamp: Date
    
    init(total: Int, timeStamp: Date) {
        self.total = total
        self.timeStamp = timeStamp
    }
}

@Model
class LastChosenDice {
    var chosenDiceCounts: [Int: Int]
    
    init(chosenDiceCounts: [Int : Int]) {
        self.chosenDiceCounts = chosenDiceCounts
    }
}

@Model
class DiceHistory {
    @Relationship(deleteRule: .cascade) var rolls: [DiceRoll]
    var lastChosenDice: LastChosenDice?

    init(rolls: [DiceRoll] = [], lastChosenDice: LastChosenDice? = nil) {
        self.rolls = rolls
        self.lastChosenDice = lastChosenDice
    }
}
