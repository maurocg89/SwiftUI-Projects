//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Mauro Grillo on 05/09/2023.
//

import Foundation
import LocalAuthentication
import MapKit

extension MapView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false

        let savedFileName = "SavedPlaces"

        init() {
            let locationsSaved: [Location]?
            locationsSaved = FileManager().getData(savedFileName)
            guard locationsSaved != nil, !locationsSaved!.isEmpty else {
                locations = []
                return
            }
            locations = locationsSaved!
        }

        func save() {
            FileManager().saveData(savedFileName, locations)
        }

        func addLocation() {
            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }

        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }

            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }

        func authenticate() {
            let context = LAContext()
            var error: NSError?
            // This method does not run on the MainActor, to avoid errors, we need to tell Swift that it should be run on the MainActor
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        // We are saying that all closure should be executed on the MainActor
                        Task { @MainActor in
                            self.isUnlocked = true
                        }
                    } else {
                        // error
                    }
                }
            } else {
                // no biometrics
            }
        }
    }
}
