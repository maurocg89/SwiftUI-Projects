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
    var isDetailView: Bool = true
    var buttonAction: (() -> Void)?
    var locationManager = LocationManager()

    var body: some View {
        VStack {
            mapSection
            formSection
        }
        .onAppear {
            if !isDetailView {
                locationManager.setup()
            }
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }

    private var mapSection: some View {
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

                markLocationButton
            } // Edit Mode
        } // ZStack
    }

    private var markLocationButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    self.location = Location(id: UUID(), name: location.name, latitude: self.mapRegion.center.latitude, longitude: self.mapRegion.center.longitude)
                    buttonAction?()
                } label: {
                    Image(systemName: "plus")
                        .padding()
                        .background(.blue.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.footnote)
                        .clipShape(Circle())
                        .padding(.trailing)
                }
            } // HStack
            .padding(.bottom)
        } // VStack
    }

    private var formSection: some View {
        Form {
            Section("Place Description") {
                TextField("", text: $location.name)
                    .disabled(isDetailView)
                    .lineLimit(1)
                    .submitLabel(.done)
            }
        }
        .scrollDisabled(true)
    }
}

#Preview {
    MapView(mapRegion: .constant(Location.mapRegionExample), location: .constant(Location.example), isDetailView: false, buttonAction: {})
}
