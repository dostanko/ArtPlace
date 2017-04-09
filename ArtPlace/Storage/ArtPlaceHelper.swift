//
//  ArtPlaceHelper.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import Foundation
import CoreData

class ArtPlaceHeper {
    
    var storage = Storage.access
    var context = Storage.context
    
    func create(title: String, comments: String, longitude: Double, latitude: Double) throws -> ArtPlace {
        var aPlace : ArtPlace?
        if let artPlace = storage.getEntity(t: aPlace) {
            artPlace.title = title
            artPlace.comments = comments
            artPlace.latitude = latitude
            artPlace.longitude = longitude
            aPlace = artPlace 
            storage.saveContext()
            return artPlace
        } else {
            throw StorageError.create("Error creating Art Place")
        }
    }
    
    func create(jsonPlace : [String: Any]) throws  -> ArtPlace {
        if let title = jsonPlace["name"] as? String,
            let lng = jsonPlace["lng"] as? Double,
            let lat = jsonPlace["lat"] as? Double {
            return try create(title: title, comments: "", longitude: lng, latitude: lat)
        } else {
            throw StorageError.create("JSON error")
        }
    }
    
    func update(objetctID: NSManagedObjectID, title: String, comments: String) throws  {
        if let arctPlaceModel =  context.object(with: objetctID) as? ArtPlace {
            arctPlaceModel.title = title
            arctPlaceModel.comments = comments
            storage.saveContext()
        } else {
            throw StorageError.update("Error updating Art Place")
        }
    }
    
    func delete(objetctID: NSManagedObjectID) throws  {
        if let arctPlaceModel =  context.object(with: objetctID) as? ArtPlace {
            context.delete(arctPlaceModel)
            storage.saveContext()
        } else {
            throw StorageError.delete("Error deleting Art Place")
        }
    }
    
    func getAll()  throws -> [ArtPlace] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: String.classToString(ArtPlace.self))
        return try context.fetch(fetchRequest as! NSFetchRequest<ArtPlace>)
    }
    
}
