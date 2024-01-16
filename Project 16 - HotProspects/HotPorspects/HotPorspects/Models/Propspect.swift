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
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let saveKey = "SavedData"

    init() {
        let peopleSaved: [Prospect]?
        peopleSaved = FileManager().getData(saveKey)
        guard peopleSaved != nil else {
            // no saved data!
            people = []
            return
        }
        people = peopleSaved!
    }

    private func save() {
        FileManager().saveData(saveKey, people)
    }

    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
