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
        @Published var newLocationName = Location.example.name
        @Published var selectedPersonLocation = Location.example

        func getPersonUpdated(_ id: UUID) {
            selectedPerson = PeopleServices.shared.getPersonById(id) ?? Person.example
            
            mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: selectedPerson.location?.latitude ?? 0, longitude: selectedPerson.location?.longitude ?? 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))

            selectedPersonLocation = selectedPerson.location ?? Location.example

            newLocationName = selectedPerson.location?.name ?? ""
        }
    }
}
