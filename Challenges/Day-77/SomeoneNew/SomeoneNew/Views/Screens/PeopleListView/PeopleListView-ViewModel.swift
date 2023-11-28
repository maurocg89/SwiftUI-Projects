//
//  PeopleListView-ViewModel.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 15/10/2023.
//

import Foundation
import Observation
import UIKit

extension PeopleListView {
//    MARK: iOS 17 new implementation
//    @MainActor
//    @Observable class ViewModel {
//        var selectedPerson: Person?
//        private(set) var people: [Person]
    @MainActor class ViewModel: ObservableObject {
        @Published var selectedPerson: Person?
        @Published private(set) var people: [Person]

        let savedFileName = "SavedPeople"

        init() {
            let peopleSaved: [Person]?
            peopleSaved = FileManager().getData(savedFileName)
            guard peopleSaved != nil, !peopleSaved!.isEmpty else {
//                people = Person.examplePeople
                people = []
                return
            }
            people = peopleSaved!
        }

        func resetData() {
            FileManager().resetData(savedFileName)
            getPeople()
        }

        func getPeople() {
            let peopleSaved: [Person]?
            peopleSaved = FileManager().getData(savedFileName)
            guard peopleSaved != nil, !peopleSaved!.isEmpty else {
                people = []
                return
            }
            people = peopleSaved!
        }

        // TODO: Pasar al EditPersonViewModel
        //        func update(person: Person) {
        //            guard let selectedPerson = selectedPerson else { return }
        //
        //            if let index = people.firstIndex(of: selectedPerson) {
        //                people[index] = person
        //                save()
        //            }
        //        }
        //
        //        func delete(person: Person) {
        //            if let index = people.firstIndex(of: person) {
        //                people.remove(at: index)
        //                save()
        //            }
        //        }
    }
}
