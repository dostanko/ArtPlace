//
//  ListInteractor.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import Foundation
import MapKit

typealias GetListPlacesCallback = (_ status: CallbackStatus, _ place: [ListArtPlacePO]?) -> (Void)

class ListInteractor {
    
    var storage : ManagablePlaces = Storage.access
    
    func getPlacesAnnotations (callback : GetListPlacesCallback) {
        var placeAnnotaions : [ListArtPlacePO] = []
        storage.getPlaces { (status, placeMOs) -> (Void) in
            switch status {
            case .ok:
                for placeMO in placeMOs {
                    let coordinate = CLLocationCoordinate2D(latitude: placeMO.latitude, longitude: placeMO.longitude)
                    let text = "\(placeMO.title ?? "")\nlat: \(roundTo6(val:placeMO.latitude));lng: \(roundTo6(val:placeMO.longitude))"
                    let details = "\(LocationProcessor.distanceToCurLocation(coordinate: coordinate).rounded())km"
                    let place = ListArtPlacePO(
                        text: text,
                        detailText: details,
                        title: placeMO.title ?? "",
                        objetctID:  placeMO.objectID,
                        comments: placeMO.comments ?? "",
                        coordinate: coordinate)
                    
                    placeAnnotaions.append(place)
                }
                
                placeAnnotaions.sort(by: {
                    LocationProcessor.distanceToCurLocation(coordinate: $0.coordinate)  <
                        LocationProcessor.distanceToCurLocation(coordinate: $1.coordinate) })
                callback(status, placeAnnotaions)
            case .error:
                callback(status, nil)
            }
            
        }
    }
    
    func roundTo6(val: Double) -> Double{
        return (val * 1000000).rounded()/1000000
    }
    
    
}
