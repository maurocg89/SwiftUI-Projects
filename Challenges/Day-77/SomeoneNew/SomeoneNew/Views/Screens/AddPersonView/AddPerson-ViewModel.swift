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
        @Published var newPersonName = ""
        @Published var newPersonLastName = ""
        @Published var inputImage: UIImage?
        @Published private(set) var people: [Person]

        let savedFileName = "SavedPeople"
        let compressionQuality = 0.8

        init() {
            let peopleSaved: [Person]?
            peopleSaved = FileManager().getData(savedFileName)
            guard peopleSaved != nil, !peopleSaved!.isEmpty else {
                people = []
                return
            }
            people = peopleSaved!
        }

        func save() {
            FileManager().saveData(savedFileName, people)
        }

        func addPerson() {
            if isFormValid() {
                addPerson(name: self.newPersonName, lastName: self.newPersonLastName, image: self.inputImage!)
            }
        }

        private func addPerson(name: String, lastName: String = "", image: UIImage) {
            guard let imageData = image.jpegData(compressionQuality: compressionQuality) else {
                // showError
                return
            }
            let newPerson = Person(id: UUID(), name: name, lastName: lastName, imageData: imageData)
            people.append(newPerson)
            save()
        }

        func isFormValid() -> Bool {
            return !newPersonName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty 
            && !newPersonLastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && inputImage != nil
        }
    }
}
