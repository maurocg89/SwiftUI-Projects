//
//  LocationManager.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 18/12/2023.
//

import Foundation
import MapKit


class LocationManager: NSObject {
    private let locationManager = CLLocationManager()
    private var mapRegion = Location.mapRegionExample

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.setup()
    }

    func setup() {
        switch locationManager.authorizationStatus {
            //If we are authorized then we request location just once,
            // to center the map
        case .authorizedWhenInUse:
            locationManager.requestLocation()
            //If we don´t, we request authorization
        case .notDetermined:
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }

    func getUserLocation() -> MKCoordinateRegion {
        locationManager.requestLocation()
        return mapRegion
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard .authorizedWhenInUse == manager.authorizationStatus else { return }
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        guard let latestLocation = locations.first else { return }
        
        DispatchQueue.main.async {
            self.mapRegion = MKCoordinateRegion(center: latestLocation.coordinate, span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01))
            debugPrint("USER LOCATION: \(self.mapRegion.center)")
        }
    }
}
