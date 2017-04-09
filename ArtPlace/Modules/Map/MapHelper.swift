//
//  MapHelper.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import Foundation
import MapKit

class MapHelper : NSObject, MKMapViewDelegate {
    
    let interactor = MapInteractor()
    private let annotationIdentifier = "ArtPlacePin"
    
    var contoller : MapController? {
        didSet {
            contoller?.placesMap.delegate = self
        }
    }
    
    func handleLongPress(_ getstureRecognizer : UIGestureRecognizer){
        if getstureRecognizer.state != .began { return }
        
        let touchPoint = getstureRecognizer.location(in: contoller?.placesMap)
        guard let touchMapCoordinate = contoller?.placesMap.convert(touchPoint, toCoordinateFrom: contoller?.placesMap)
            else { return }
        
        interactor.createPlace(coordinate: touchMapCoordinate, callback: { status, newPin in
            switch status {
            case .ok:
                if let pin = newPin {
                    contoller?.addAnnotation(annotation: pin)
                }
            case .error(let message):
                contoller?.showErrorAllert(message: message)
            }
            
        })
        
    }
    
    func setupInitialMap() {
        interactor.getPlacesAnnotations(callback : { status, annotations in
            switch status {
            case .ok:
                contoller?.addAnnotations(annotations: annotations ?? [])
            case .error(let message):
                contoller?.showErrorAllert(message: message)
            }
        })
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ArtPlaceAnnotation {
            let view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view.canShowCallout = true
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            return view
        }
        return nil
    }
    
    public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? ArtPlaceAnnotation  {
            let detailsArtPlace = DetailsArtPlacePO(
                objetctID : annotation.objetctID,
                title : annotation.title ?? "",
                comments : annotation.comments,
                coordinate : annotation.coordinate)
             contoller?.showDetails(place: detailsArtPlace)
        
        }
    }
    
}
