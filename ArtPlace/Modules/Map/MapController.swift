//
//  MapController.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var placesMap: MKMapView!
    let helper : MapHelper = MapHelper()

    override func viewDidLoad() {
        super.viewDidLoad()

        helper.contoller = self
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(sydneyCenter.coordinate, initRegionRadius, initRegionRadius)
        placesMap.setRegion(coordinateRegion, animated: true)
        
        let longPressRecogniser = UILongPressGestureRecognizer(target: helper, action: #selector(helper.handleLongPress(_:)))
        longPressRecogniser.minimumPressDuration = 1.0
        placesMap.addGestureRecognizer(longPressRecogniser)

    }
    
    func showDetails(place: DetailsArtPlacePO){
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsStoryboard") as! DetailsController
        vc.artPlace = place
        tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        placesMap.removeAnnotations(placesMap.annotations)
        helper.setupInitialMap()
    }
    
    
    func addAnnotation(annotation: ArtPlaceAnnotation) {
        placesMap.addAnnotation(annotation)
    }
    
    func addAnnotations(annotations: [ArtPlaceAnnotation]) {
        placesMap.addAnnotations(annotations)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

