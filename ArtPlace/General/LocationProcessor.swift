//
//  LocationProcessor.swift
//  ArtPlace
//
//  Created by Ira on 4/7/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import Foundation
import CoreLocation

class LocationProcessor : NSObject, CLLocationManagerDelegate {
    
    static public let access = LocationProcessor()
    let locationManager = CLLocationManager()
    
    private override init() {
        super.init()
        if CLLocationManager.authorizationStatus() == .notDetermined {
            LocationProcessor.access.locationManager.requestWhenInUseAuthorization()
        }
       
    }
    
    class func distanceToCurLocation(coordinate: CLLocationCoordinate2D) -> Double {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            return 0
        }

        let distance = (LocationProcessor.access.locationManager.location?.distance(from:
            CLLocation(latitude: coordinate.latitude,longitude: coordinate.longitude))) ?? 0
        //get kms
        return distance.rounded()/1000
    }
    

}
