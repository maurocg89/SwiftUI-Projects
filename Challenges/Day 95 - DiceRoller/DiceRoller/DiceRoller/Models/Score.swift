//
//  Score.swift
//  DiceRoller
//
//  Created by Mauro Grillo on 18/01/2024.
//

import Foundation

struct Score: Codable, Identifiable {
    var id: UUID
    let score: Int
    let amountOfDices: Int
}

extension Score {
    static let totalScoresKey = "total_scores"
    static let dicesAmountKey = "amount_of_dices"
    static let savedFileName = "SavedScores"
    static let maximumCapacity = 20
    static let examples = Array(repeating: Score(id: UUID(), score: .random(in: 1...20), amountOfDices: 10), count: 20)
}
