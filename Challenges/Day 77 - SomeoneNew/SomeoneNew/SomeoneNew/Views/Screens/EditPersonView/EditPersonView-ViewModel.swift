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
        @Published var mapRegion = Location.mapRegionExample
        @Published var personLocation = Location.empty

        let compressionQuality = 0.8

        public init(selectedPerson: Person) {
            self.selectedPerson = selectedPerson
            self.inputImage = self.selectedPerson.image
            if let region = selectedPerson.location?.mapRegion {
                self.mapRegion = region
            }
            if let location = selectedPerson.location {
                self.personLocation = location
            }
        }

        func update(personUpdated: Person) {
            PeopleServices.shared.updatePerson(personUpdated)
        }

        func updatePerson() {
            guard inputImage != nil, let imageData = inputImage!.jpegData(compressionQuality: compressionQuality) else {
                return
            }
            let updateLocation = selectedPerson.location != nil && selectedPerson.location != Location.empty

            let personUpdated = Person(id: selectedPerson.id, name: selectedPerson.name, lastName: selectedPerson.lastName, description: selectedPerson.description, imageData: imageData, location: updateLocation ? selectedPerson.location : nil)
            self.update(personUpdated: personUpdated)
        }

        func delete(person: Person) {
            PeopleServices.shared.deletePerson(id: person.id)
        }

        func isFormValid() -> Bool {
            return !selectedPerson.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !selectedPerson.lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && inputImage != nil
            && (selectedPerson.location != nil && selectedPerson.location != Location.empty && !selectedPerson.location!.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
    }
}
