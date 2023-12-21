//
//  PersonDetailView-ViewModel.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 01/12/2023.
//

import Foundation
import MapKit

extension PersonDetailView {
    @MainActor class ViewModel: ObservableObject {
        @Published var selectedPerson = Person.example
        @Published var mapRegion = Location.mapRegionExample
        @Published var selectedPersonLocation = Location.empty

        func getPersonUpdated(_ id: UUID) {
            selectedPerson = PeopleServices.shared.getPersonById(id) ?? Person.example
            mapRegion = selectedPerson.location?.mapRegion ?? Location.mapRegionExample
            selectedPersonLocation = selectedPerson.location ?? Location.example
        }
    }
}
