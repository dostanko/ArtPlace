//
//  DetailsInteractor.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import Foundation
import CoreData

class DetailsInteractor {
    
    var contoller : DetailsController?
    
    var storage : ManagablePlaces = Storage.access
    
    func updateArtObject(objetctID : NSManagedObjectID, title : String, comments : String) {
        storage.updateArtPlace(objetctID : objetctID, title : title, comments : comments) { status in
            switch  status {
            case .ok:
                print("do nothing")
            case .error(let message):
                contoller?.showErrorAllert(message: message)
                
            }
        }
    }
    
    func deleteArtObject(objetctID : NSManagedObjectID) {
        storage.deleteArtPlace(objetctID : objetctID) { status in
            switch  status {
            case .ok:
                let _ = contoller?.navigationController?.popViewController(animated: true)
            case .error(let message):
                contoller?.showErrorAllert(message: message)
            }
        }
    }
    
}
