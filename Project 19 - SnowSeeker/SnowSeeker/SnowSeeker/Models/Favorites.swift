//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Mauro Grillo on 24/01/2024.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"

    init() {
        if let savedData = FileManager().loadData(saveKey) as Set<String>? {
            resorts = savedData
            return
        }
        resorts = []
    }

    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        FileManager().saveData(saveKey, resorts)
    }
}
