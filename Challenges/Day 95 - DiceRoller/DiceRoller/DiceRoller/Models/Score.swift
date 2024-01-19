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
}

extension Score {
    static let examples = Array(repeating: Score(id: UUID(), score: .random(in: 1...20)), count: 20)
}
