//
//  PersonDetailView-ViewModel.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 01/12/2023.
//

import Foundation

extension PersonDetailView {
    @MainActor class ViewModel: ObservableObject {
        @Published var selectedPerson = Person.example
        
        func getPersonUpdated(_ id: UUID) {
            selectedPerson = PeopleServices.shared.getPersonById(id) ?? Person.example
        }
    }
}
