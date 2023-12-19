//
//  MapView.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 14/12/2023.
//

import MapKit
import SwiftUI

struct MapView: View {
    @Binding var mapRegion: MKCoordinateRegion
    @Binding var location: Location
    @Binding var newLocationName: String
    var isDetailView: Bool = true
    var buttonAction: (() -> Void)?
    let locationManager = LocationManager()

    var body: some View {
        VStack {
            ZStack {
                Map(coordinateRegion: $mapRegion, showsUserLocation: !isDetailView, annotationItems: [location]) {
                    MapMarker(coordinate: $0.coordinate)
                } // Map
                .disabled(isDetailView)
                .ignoresSafeArea()

                if !isDetailView {
                    Circle()
                        .fill(.blue)
                        .opacity(0.3)
                        .frame(width: 22, height: 22)

                    VStack {
                        Spacer()
                        LocationButton(title: "Current Location") {
                            mapRegion = locationManager.getUserLocation()
                            debugPrint("MAPREGION: \(mapRegion.center)")
                        }
                        .symbolVariant(.fill)
                        .padding()
                    } // VStack

                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                if newLocationName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                    // Show modal
                                    return
                                }
                                self.location = Location(id: UUID(), name: newLocationName, latitude: self.mapRegion.center.latitude, longitude: self.mapRegion.center.longitude)
                                buttonAction?()
                            } label: {
                                Image(systemName: "plus")
                                    .padding()
                                    .background(.black.opacity(0.75))
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .clipShape(Circle())
                                    .padding(.trailing)
                            }
                        } // HStack
                        .padding(.bottom)
                    } // VStack
                }
            } // ZStack
            Form {
                Section("Place Description") {
                    TextField("", text: $newLocationName, axis: .vertical)
                        .disabled(isDetailView)
                }
            }
            .scrollDisabled(true)
        } // VStack
    }
}

#Preview {
    MapView(mapRegion: .constant(Location.mapRegionExample), location: .constant(Location.example), newLocationName: .constant(""), isDetailView: false, buttonAction: {})
}
