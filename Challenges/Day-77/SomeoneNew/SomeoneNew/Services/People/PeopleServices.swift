//
//  PeopleServices.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 01/12/2023.
//

import Foundation

struct PeopleServices {
    
    static let shared = PeopleServices()

    func getPeople() -> [Person] {
        return FileManager().getData(FilesNames.SAVED_PEOPLE.rawValue) ?? []
    }

    func getPersonById(_ id: UUID) -> Person? {
        let peopleSaved = self.getPeople()
        guard !peopleSaved.isEmpty else { return nil }
        return peopleSaved.first { $0.id == id }
    }

    func updatePerson(_ personUpdated: Person) {
        var peopleSaved = self.getPeople()
        guard !peopleSaved.isEmpty else {
            print("There was an error trying to update the person: \(personUpdated)")
            return
        }
        if let index = peopleSaved.firstIndex(where: { personToUpdate in
            personUpdated.id == personToUpdate.id
        }) {
            peopleSaved[index] = personUpdated
            FileManager().saveData(FilesNames.SAVED_PEOPLE.rawValue, peopleSaved)
        }
    }

    func deletePerson(id: UUID) {
        var peopleSaved = self.getPeople()
        guard !peopleSaved.isEmpty else { return }
        peopleSaved.removeAll { $0.id == id }
        FileManager().saveData(FilesNames.SAVED_PEOPLE.rawValue, peopleSaved)
    }

    func deleteAllPeople() {
        FileManager().resetData(FilesNames.SAVED_PEOPLE.rawValue)
    }


}
