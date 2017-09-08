//
//  CurrentPlaceGMS.swift
//  PROCH
//
//  Created by CdxN on 2017/8/10.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import Foundation
import GooglePlaces
import GoogleMaps

extension NearbyCofeViewController: CLLocationManagerDelegate {

    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!

        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)

        let userLocation = Location(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

        print("Location Update: \(location)")
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
        print("UserLatitude: \(userLocation.latitude )")
        print("UserLongitude: \(userLocation.longitude )")

//        if mapView.isHidden {
//            mapView.isHidden = false
//            mapView.camera = camera
//        } else {
//            mapView.animate(to: camera)
//        }

        self.userCurrentLocation = userLocation
        print(self.userCurrentLocation)
    }

    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }

    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
