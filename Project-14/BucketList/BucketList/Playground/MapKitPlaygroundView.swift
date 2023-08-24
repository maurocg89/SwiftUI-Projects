//
//  MapKitPlaygroundView.swift
//  BucketList
//
//  Created by Mauro Grillo on 19/08/2023.
//

import MapKit
import SwiftUI

struct LocationStruct: Identifiable {
    var id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapKitPlaygroundView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))

    let locations = [
        LocationStruct(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        LocationStruct(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]

    var body: some View {
        NavigationView {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
//                MapMarker(coordinate: location.coordinate)
                MapAnnotation(coordinate: location.coordinate) {
                    NavigationLink {
                        Text(location.name)
                    } label: {
                        Circle()
                            .stroke(.red, lineWidth: 3)
                            .frame(width: 44, height: 44)
                    }
                }
            }
            .navigationTitle("London Explorer")
        }

    }
}

struct MapKitPlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        MapKitPlaygroundView()
    }
}
