//
//  Mocks.swift
//  ArtPlace
//
//  Created by Ira on 4/9/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import Foundation
import MapKit
import CoreData

@testable import ArtPlace

var managedContext : NSManagedObjectContext {
    let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    let _ = try? persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
    let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    return managedObjectContext
}


class MockStorage1 : ManagablePlaces {
    let context = managedContext
    
    func getPlaces(callback: GetPlacesCallback) {
        let entity1 = NSEntityDescription.insertNewObject(forEntityName: "ArtPlace", into: context) as! ArtPlace
        entity1.title = "title1"
        entity1.comments = "comments1"
        entity1.longitude = 10.1
        entity1.latitude = 20.1
        let entity2 = NSEntityDescription.insertNewObject(forEntityName: "ArtPlace", into: context) as! ArtPlace
        entity2.title = "title2"
        callback(.ok(""), [entity1, entity2])
    }
    
    func createArtPlace(title: String, comments: String, longitude: Double, latitude: Double, callback: CreateArtPlaceCallback) {
        let entity = NSEntityDescription.entity(forEntityName: "ArtPlace", in: managedContext)!
        let place = NSManagedObject(entity: entity, insertInto: managedContext) as! ArtPlace
        callback(.ok(""), place)
    }
    
    func deleteArtPlace(objetctID : NSManagedObjectID, callback: DeleteArtPlaceCallback) {}
    
    func updateArtPlace(objetctID : NSManagedObjectID, title : String, comments : String, callback: UpdateArtPlaceCallback){ }
    
    func getEntity<Element>(t: Element?) -> Element? {
        let entity = NSEntityDescription.entity(forEntityName: "ArtPlace", in: managedContext)!
        return NSManagedObject(entity: entity, insertInto: managedContext) as? Element
    }
    
    func saveContext () {}
    static var access : ManagablePlaces = MockStorage1()
    static var context : NSManagedObjectContext = managedContext
    var artPlaceClass = ArtPlaceHeper()
    func loadDefaultPlaces(filename: String, bundle : Bundle) -> [[String: Any]] {
        return []
    }
}

class MockStorage2 : ManagablePlaces {
    
    func getPlaces(callback: GetPlacesCallback) {
        callback(.error(""), [])
    }
    
    func createArtPlace(title: String, comments: String, longitude: Double, latitude: Double, callback: CreateArtPlaceCallback) {
        callback(.error(""), nil)
    }
    
    func deleteArtPlace(objetctID : NSManagedObjectID, callback: DeleteArtPlaceCallback) {
        callback(.error(""))
    }
    
    func updateArtPlace(objetctID : NSManagedObjectID, title : String, comments : String, callback: UpdateArtPlaceCallback){
        callback(.error(""))
    }
    func getEntity<Element>(t: Element?) -> Element? {return t}
    func saveContext () {}
    static var access : ManagablePlaces = MockStorage1()
    static var context : NSManagedObjectContext = managedContext
    var artPlaceClass = ArtPlaceHeper()
    func loadDefaultPlaces(filename: String, bundle : Bundle) -> [[String: Any]] {
        return []
    }
}

enum MockError : Error {
    case MockError(String)
}

class ArtPlaceMock1 : ArtPlaceHeper {
    
    override func getAll()  throws -> [ArtPlace] {
        throw MockError.MockError("test")
    }
    
    override func create(jsonPlace : [String: Any]) throws  -> ArtPlace {
        throw MockError.MockError("test")
    }
    
    override func update(objetctID: NSManagedObjectID, title: String, comments: String) throws  {
        throw MockError.MockError("test")
    }
    
    override func delete(objetctID: NSManagedObjectID) throws  {
        throw MockError.MockError("test")
    }
    
    override func create(title: String, comments: String, longitude: Double, latitude: Double) throws -> ArtPlace {
        throw MockError.MockError("test")
    }
    
}


class ArtPlaceMock2 : ArtPlaceHeper  {
    
    enum MockError : Error {
        case MockError(String)
    }
    
    override func getAll()  throws -> [ArtPlace] {
        return []
    }
    
    override func create(jsonPlace : [String: Any]) throws  -> ArtPlace {
        return NSEntityDescription.insertNewObject(forEntityName: "ArtPlace", into: managedContext) as! ArtPlace
    }
    
    override func create(title: String,  comments: String, longitude: Double, latitude: Double) throws -> ArtPlace {
        return ArtPlace()
    }
    
    override func update(objetctID: NSManagedObjectID, title: String, comments: String) throws  {}
    
    override func delete(objetctID: NSManagedObjectID) throws  {}
    
}
