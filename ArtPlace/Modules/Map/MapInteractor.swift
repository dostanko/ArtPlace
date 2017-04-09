//
//  MapInteractor.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import Foundation
import MapKit

typealias CreatePlaceCallback = (_ status: CallbackStatus, _ place: ArtPlaceAnnotation?) -> (Void)
typealias GetPlacesAnnotationsCallback = (_ status: CallbackStatus, _ annotations: [ArtPlaceAnnotation]?) -> (Void)

class MapInteractor {
    
    var storage : ManagablePlaces = Storage.access
    
    func getPlacesAnnotations (callback: GetPlacesAnnotationsCallback) {
        var placeAnnotaions : [ArtPlaceAnnotation] = []
        storage.getPlaces { (status, placeMOs) -> (Void) in
            switch status {
            case .ok:
                for placeMO in placeMOs {
                    let place = ArtPlaceAnnotation(title: placeMO.title ?? "",
                                                   comments: placeMO.comments ?? "",
                                                   longitude: placeMO.longitude,
                                                   latitude: placeMO.latitude,
                                                   objetctID: placeMO.objectID)
                    placeAnnotaions.append(place)
                }
                callback(status, placeAnnotaions)
            case .error:
                callback(status, nil)
            }
        }
    }
    
    func createPlace(coordinate: CLLocationCoordinate2D, callback: CreatePlaceCallback) {
        storage.createArtPlace(title: "New Place", comments: "",
                               longitude: coordinate.longitude,  latitude: coordinate.latitude,
                               callback:
            { status, place in
                switch status {
                case .ok:
                    guard let artPlace = place
                        else { return}
                    let newPin = ArtPlaceAnnotation(title: artPlace.title ?? "",
                                                    comments: artPlace.comments ?? "",
                                                    longitude: artPlace.longitude,
                                                    latitude: artPlace.latitude,
                                                    objetctID: artPlace.objectID)
                    callback(status, newPin)
                case .error:
                    callback(status, nil)
                    
                }
        })
    }
    
}
