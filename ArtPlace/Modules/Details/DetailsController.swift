//
//  DetailsController.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import UIKit
import MapKit
import CoreData

struct DetailsArtPlacePO {
    var objetctID : NSManagedObjectID
    var title : String
    var comments : String
    var coordinate : CLLocationCoordinate2D
}

class DetailsController : UIViewController {
    
    @IBOutlet weak var content: UIScrollView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var commentField: UITextView!
    @IBOutlet weak var placeMap: MKMapView!
    
    var artPlace : DetailsArtPlacePO?
    
    let interactor = DetailsInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.contoller = self
        title = "Details"
        nameField.text = artPlace?.title
        commentField.text = artPlace?.comments
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(sydneyCenter.coordinate, initRegionRadius, initRegionRadius)
        placeMap.setRegion(coordinateRegion, animated: true)
        if let place = artPlace {
            let annotation = ArtPlaceAnnotation(title: place.title,
                                                comments: place.comments,
                                                longitude: place.coordinate.longitude,
                                                latitude: place.coordinate.latitude,
                                                objetctID: place.objetctID)
            placeMap.addAnnotation(annotation)
        }

        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(switchKeyboard),
            name: .UIKeyboardWillHide,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(switchKeyboard),
            name: .UIKeyboardWillChangeFrame,
            object: nil)
    }

    @IBAction func deleteArtPlace(_ sender: Any) {
        interactor.deleteArtObject(objetctID: artPlace!.objetctID)
    }
    
    func switchKeyboard(notification: Notification){
        let keyboardScreenEndFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: nil)
        
        let contentInsets = (notification.name == .UIKeyboardWillHide)  ?
            UIEdgeInsets.zero :
            UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)

        content.scrollIndicatorInsets = contentInsets
        content.contentInset = contentInsets
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        interactor.updateArtObject(objetctID: artPlace!.objetctID,
                                   title: nameField.text ?? "",
                                   comments: commentField.text ?? "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
