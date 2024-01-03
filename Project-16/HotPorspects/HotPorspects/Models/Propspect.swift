//
//  Propspect.swift
//  HotPorspects
//
//  Created by Mauro Grillo on 03/01/2024.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published var people: [Prospect]

    init() {
        people = []
    }
}
