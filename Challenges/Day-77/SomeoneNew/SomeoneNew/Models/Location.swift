//
//  Location.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 14/12/2023.
//

import MapKit
import Foundation

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static let mapRegionExample = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -32.953542, longitude: -60.678115), span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))

    static let example = Location(id: UUID(), name: "Buckingham Palace", latitude: 51.501, longitude: -0.141)

    static let empty = Location(id: UUID(), name: "", latitude: 0, longitude: 0)

    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
