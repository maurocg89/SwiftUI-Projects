//
//  AddPerson-ViewModel.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 27/10/2023.
//

import Foundation
import UIKit

extension AddPersonView {
    @MainActor class ViewModel: ObservableObject {
        @Published var showAddImageSheet = false
        @Published var inputImage: UIImage?
        @Published var mapRegion = Location.mapRegionExample
        @Published var newPerson = Person.empty
        @Published private(set) var people: [Person]

        let compressionQuality = 0.8

        init() {
            let peopleSaved: [Person]?
            peopleSaved = FileManager().getData(FilesNames.SAVED_PEOPLE.rawValue)
            guard peopleSaved != nil, !peopleSaved!.isEmpty else {
                people = []
                return
            }
            people = peopleSaved!
        }

        func save() {
            FileManager().saveData(FilesNames.SAVED_PEOPLE.rawValue, people)
        }

        func addPerson() {
            addPerson(name: self.newPerson.name, lastName: self.newPerson.lastName, description: self.newPerson.description, image: self.inputImage!, location: self.newPerson.location ?? Location.empty)
        }

        private func addPerson(name: String, lastName: String = "", description: String = "", image: UIImage, location: Location) {
            guard let imageData = image.jpegData(compressionQuality: compressionQuality) else {
                // showError
                return
            }
            let newPerson = Person(id: UUID(), name: name, lastName: lastName, description: description, imageData: imageData, location: location)
            people.append(newPerson)
            save()
        }
    }
}
