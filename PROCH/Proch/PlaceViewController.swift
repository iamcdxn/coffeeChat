//
//  PlaceViewController.swift
//  PROCH
//
//  Created by CdxN on 2017/8/10.
//  Copyright © 2017年 CdxN. All rights reserved.
//
//
//import UIKit
//import GooglePlaces
//import GooglePlacePicker
//
//class PlacesViewController: UIViewController {
//    
//    var likelyPlaces: [GMSPlace] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Do any additional setup after loading the view.
//    }
//    
//    // Pass the selected place to the new view controller.
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "unwindToMain" {
//            if let nextViewController = segue.destination as? MapViewController {
//                nextViewController.selectedPlace = selectedPlace
//            }
//        }
//    }
//    
//    // Update the map once the user has made their selection.
//    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
//        // Clear the map.
//        mapView.clear()
//        
//        // Add a marker to the map.
//        if selectedPlace != nil {
//            let marker = GMSMarker(position: (self.selectedPlace?.coordinate)!)
//            marker.title = selectedPlace?.name
//            marker.snippet = selectedPlace?.formattedAddress
//            marker.map = mapView
//        }
//        
//        listLikelyPlaces()
//    }
//    
//}
//
//// Populate the table with the list of most likely places.
//extension PlacesViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return likelyPlaces.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
//        let collectionItem = likelyPlaces[indexPath.row]
//        
//        cell.textLabel?.text = collectionItem.name
//        
//        return cell
//    }
//    
//    // Show only the first five items in the table (scrolling is disabled in IB).
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return self.tableView.frame.size.height/5
//    }
//    
//    // Make table rows display at proper height if there are less than 5 items.
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if (section == tableView.numberOfSections - 1) {
//            return 1
//        }
//        return 0
//    }
//}
//
//// Respond when the user selects a place.
//extension PlacesViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedPlace = likelyPlaces[indexPath.row]
//        performSegue(withIdentifier: "unwindToMain", sender: self)
//    }
//}
