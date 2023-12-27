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
    @MainActor class ViewModel: ObservableObject {
        @Published var people: [Person]
        @Published var showingGrid = false

        init() {
            people = PeopleServices.shared.getPeople()
        }

        func deletePerson(id: UUID) {
            Task {
                PeopleServices.shared.deletePerson(id: id)
            }
        }

        func resetData() {
            PeopleServices.shared.deleteAllPeople()
            self.getPeople()
        }

        func getPeople() {
            self.people = PeopleServices.shared.getPeople()
        }
    }
}
