//
//  EditPersonView-ViewModel.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 30/11/2023.
//

import Foundation
import UIKit

extension EditPersonView {
    @MainActor class ViewModel: ObservableObject {
        @Published var selectedPerson = Person.example
        @Published var inputImage: UIImage?
        @Published var showAddImageSheet = false

        let compressionQuality = 0.8

        func update(personUpdated: Person) {
            PeopleServices.shared.updatePerson(personUpdated)
        }

        func updatePerson() {
            guard inputImage != nil, let imageData = inputImage!.jpegData(compressionQuality: compressionQuality) else {
                return
            }
            let personUpdated = Person(id: selectedPerson.id, name: selectedPerson.name, lastName: selectedPerson.lastName, imageData: imageData)
            self.update(personUpdated: personUpdated)
        }

        func delete(person: Person) {
            PeopleServices.shared.deletePerson(id: person.id)
        }

        func getPersonById(_ id: UUID) {
            self.selectedPerson = PeopleServices.shared.getPersonById(id) ?? Person.example
            self.inputImage = self.selectedPerson.image
        }
    }
}
