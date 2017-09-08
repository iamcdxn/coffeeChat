//
//  NearbyCofeViewController.swift
//  PROCH
//
//  Created by CdxN on 2017/8/8.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit
import GooglePlaces
import GooglePlacePicker

struct Location {

    var latitude: Double
    var longitude: Double

}

class NearbyCofeViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var getPlaceBtn: UIButton!

    var userCurrentLocation = Location(latitude: 0.000000, longitude: 0.000000)

    var placesClient: GMSPlacesClient!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var zoomLevel: Float = 15.0

    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []

    // The currently selected place.
    var selectedPlace: GMSPlace?

    override func viewDidLoad() {
        super.viewDidLoad()

        placesClient = GMSPlacesClient.shared()

        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self

        let camera = GMSCameraPosition.camera(withLatitude: 25.027345,
                                              longitude: 121.555645,
                                              zoom: zoomLevel)

        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //mapView.isMyLocationEnabled = true

        // Add the map to the view, hide it until we've got a location update.
        view.addSubview(mapView)
        mapView.isHidden = true

//        getNearCode()

    }

    @IBAction func getCurrentPlace(_ sender: Any) {
//        configureLocationServices()
//        pickPlace(sender: self.getPlaceBtn)
        getNearCode()
    }

    func getCurrentPlace(sender: UIButton) {

        placesClient.currentPlace { (placeLikelihoodList, error) in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")

                return
            }

            self.nameLabel.text = "No current place"
            self.addressLabel.text = ""

            if let plaLikelihoodList = placeLikelihoodList {
                let place = plaLikelihoodList.likelihoods.first?.place

                if let place = place {
                    self.nameLabel.text = place.name
                    self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ").joined(separator: "\n")
                }
            }
        }
    }

    func pickPlace(sender: UIButton) {

//        let center = CLLocationCoordinate2D(latitude: 37.788204, longitude: -122.411937)
//        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001, longitude: center.longitude + 0.001)
//        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001, longitude: center.longitude - 0.001)
//        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
//        let config = GMSPlacePickerConfig(viewport: viewport)
//        let placePicker = GMSPlacePicker(config: config)
//        
//        placePicker.pickPlace(callback: {(place, error) -> Void in
//            if let error = error {
//                print("Pick Place error: \(error.localizedDescription)")
//                return
//            }
//            
//            if let place = place {
//                self.nameLabel.text = place.name
//                self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
//                    .joined(separator: "\n")
//            } else {
//                self.nameLabel.text = "No place selected"
//                self.addressLabel.text = ""
//            }
//        })

        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePicker(config: config)

        placePicker.pickPlace(callback: { (place, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }

            guard let place = place else {
                print("No place selected")
                return
            }

            print("Place name \(place.name)")
            print("Place address \(place.formattedAddress)")
            print("Place attributions \(place.attributions)")
        })

    }

    func configureLocationServices() {
        // Send location updates to the current object.
        self.locationManager.delegate = self as? CLLocationManagerDelegate
        // Request authorization, if needed.
        let authorizationStatus = CLLocationManager.authorizationStatus()
        switch authorizationStatus {
        case .notDetermined:
            // Request authorization.
            self.locationManager.requestWhenInUseAuthorization()
            break

        // Do nothing otherwise.
        default: break
        }
    }

    // Populate the array with the list of likely places.
    func listLikelyPlaces() {
        // Clean up from previous sessions.
        likelyPlaces.removeAll()

        placesClient.currentPlace(callback: { (placeLikelihoods, error) -> Void in
            if let error = error {
                // TODO: Handle the error.
                print("Current Place error: \(error.localizedDescription)")
                return
            }

            // Get likely places and add to the list.
            if let likelihoodList = placeLikelihoods {
                for likelihood in likelihoodList.likelihoods {
                    let place = likelihood.place
                    self.likelyPlaces.append(place)
                }
            print(self.likelyPlaces)
            }
        })
    }

}
