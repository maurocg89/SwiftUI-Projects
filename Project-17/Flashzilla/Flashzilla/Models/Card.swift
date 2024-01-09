//
//  Card.swift
//  Flashzilla
//
//  Created by Mauro Grillo on 05/01/2024.
//

import Foundation

struct Card: Codable, Identifiable {
    var id: UUID
    let prompt: String
    let answer: String
}

extension Card {
    static let example = Card(id: UUID(), prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")

    static let savedFileName = "SavedCards"
}
