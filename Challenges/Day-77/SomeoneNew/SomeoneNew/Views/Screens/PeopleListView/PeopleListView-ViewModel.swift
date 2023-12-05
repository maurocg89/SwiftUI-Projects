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
        @Published var people: [Person]

        init() {
            people = PeopleServices.shared.getPeople()
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
