//
//  GMSNearbySearch.swift
//  PROCH
//
//  Created by CdxN on 2017/8/10.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import Foundation
import Alamofire

extension NearbyCofeViewController {

    func getNearCode() {

        Alamofire.request("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(self.userCurrentLocation.latitude),\(self.userCurrentLocation.longitude)&radius=50000&type=cafe&keyword=&key=AIzaSyA-Mrs6cVZhERvynt5hZ6a7m8QBYVzirbg").responseJSON { response in
            debugPrint(response)

            if let json = response.result.value {
                print("JSON: \(json)")
            }
        }
    }
}
